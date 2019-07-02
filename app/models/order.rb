require 'state_machine'

class Order < ActiveRecord::Base
  belongs_to :user
  has_one :receipt
  has_many :order_items

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

end
