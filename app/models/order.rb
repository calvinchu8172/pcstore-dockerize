require 'state_machine'

class Order < ActiveRecord::Base
  belongs_to :user
  has_one :receipt
  has_many :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :receipt, allow_destroy: true

  def total_price
    order_items.inject(0) { |sum, item| sum + item.price }
  end

  state_machine :state, initial: :new do
    event :paid do
      transition :new => :paid
    end

    event :deliver do
      transition :paid => :delivered
    end

    after_transition :new => :paid do
    end

    after_transition :paid => :delivered do
    end
  end

  def status
    if self.is_failed?
      I18n.t("order.state.failed")
    elsif self.state == 'new'
      I18n.t("order.state.new")
    elsif self.state == 'paid'
      I18n.t("order.state.paid")
    end
  end

  def not_paid?
    if self.state == 'new'
      true
    else
      false
    end
  end

  def self.default_order_start_datetime(user)
    if user.orders.first.blank?
      Time.now
    else
      user.orders.first.created_at
    end
  end

  def self.check_user_order_item_available(user)
    user.orders.each do |order|
      unless order.is_failed?
        result = false
        
        order.order_items.each do |order_item|  
          if Product.unscoped.find(order_item.product_id).is_online == false
            order_item.update(is_unavailable: true, unavailable_reason: 'offline')
            result = true
          elsif Product.unscoped.find(order_item.product_id).is_recycled == true
            order_item.update(is_unavailable: true, unavailable_reason: 'recycled')
            result = true
          elsif Product.unscoped.find(order_item.product_id).nil?
            order_item.update(is_unavailable: true, unavailable_reason: 'deleted')
            result = true          
          end
        end

        if result == true
          order.update(is_failed: true)
        end
      end
    end
  end

end
