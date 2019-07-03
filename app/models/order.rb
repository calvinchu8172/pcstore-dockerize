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
    case self.state
    when 'new'
      I18n.t("order.state.new")
    when 'paid'
      I18n.t("order.state.paid")
    else
      I18n.t("order.state.unknown")
    end
  end

  def not_paid?
    if self.state == 'new'
      true
    else
      false
    end
  end

end
