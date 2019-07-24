class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_one :receipt
  has_many :order_items
  accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :receipt, allow_destroy: true

  def total_price
    order_items.inject(0) { |sum, item| sum + item.price }
  end

  aasm column: :state do
    state :new, initial: true
    state :paid, :shipping, :delivered, :returned, :refunded, :failed

    event :pay do
      transitions from: :new, to: :paid
    end

    event :failed do
      transitions from: :new, to: :failed
    end

    # event :pay_if_items_exist do
    #   transitions from: :new, to: :paid, guard: :check_order_items
    #   transitions from: :new, to: :failed
    # end

    event :ship do
      transitions from: :paid, to: :shipping
    end

    event :delivering do
      transitions from: :shipping, to: :delivered
    end

    event :return do
      transitions from: [:delivered, :shipping], to: :returned
    end

    event :refund do
      transitions from: [:paid, :returned], to: :refunded
    end
  end

  def status
    if self.failed?
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
      self.check_order_items_available(order)
    end
  end

  def self.check_order_items_available(order)
    if order.new?
      result = true
      
      order.order_items.each do |order_item|  
        if Product.unscoped.find(order_item.product_id).is_online == false
          order_item.update(is_unavailable: true, unavailable_reason: 'offline')
          result = false
        elsif Product.unscoped.find(order_item.product_id).is_recycled == true
          order_item.update(is_unavailable: true, unavailable_reason: 'recycled')
          result = false
        elsif Product.unscoped.find(order_item.product_id).nil?
          order_item.update(is_unavailable: true, unavailable_reason: 'deleted')
          result = false         
        end
      end

      if result == false
        order.failed!
      end
    end
  end

  # def check_order_items(order)
  #   if order.new?
  #     result = true
      
  #     order.order_items.each do |order_item|  
  #       if Product.unscoped.find(order_item.product_id).is_online == false
  #         order_item.update(is_unavailable: true, unavailable_reason: 'offline')
  #         result = false
  #       elsif Product.unscoped.find(order_item.product_id).is_recycled == true
  #         order_item.update(is_unavailable: true, unavailable_reason: 'recycled')
  #         result = false
  #       elsif Product.unscoped.find(order_item.product_id).nil?
  #         order_item.update(is_unavailable: true, unavailable_reason: 'deleted')
  #         result = false         
  #       end
  #     end
  #     result
  #   end
  # end

end
