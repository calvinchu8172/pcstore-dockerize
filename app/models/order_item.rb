class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def price
    quantity.blank?? 0 : product.price * quantity
  end

  def reason
    if unavailable_reason == 'offline'
      I18n.t('order_item.unavailable_reason.offline')
    elsif unavailable_reason == 'recycled'
      I18n.t('order_item.unavailable_reason.offline')
    elsif unavailable_reason == 'deleted'
      I18n.t('order_item.unavailable_reason.deleted')
    end
  end
end
