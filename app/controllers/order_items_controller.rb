class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order
  before_action :find_order_item, only: [:destroy]
  
  def create
    product = Product.find_by(id: order_item_params[:product_id])
    if product.nil?
      redirect_to edit_order_path(@order), danger: I18n.t('add_product_failed')
    else
      order_item = @order.order_items.find_by(product_id: order_item_params[:product_id])
      if order_item.nil?
        
        @order.order_items.create( product_id: order_item_params[:product_id], 
          product_name: Product.find(order_item_params[:product_id]).name, 
          quantity: order_item_params[:quantity],
          product_price: Product.find(order_item_params[:product_id]).price
        )
      else
        order_item.update( quantity: order_item.quantity + order_item_params[:quantity].to_i )
      end
      
      redirect_to edit_order_path(@order), success: I18n.t('add_product_successful')
    end

  end

  def destroy
    if @order_item.destroy
      redirect_to edit_order_path(@order), success: I18n.t('order_item.destroy.success', order_item: @order_item.product_name)
    else
      redirect_to edit_order_path(@order), danger: I18n.t('order_item.destroy.failed', order_item: @order_item.product_name)
    end
  end
  
  private

  def order_item_params
    params.require(:order_item).permit(:id, :product_id, :product_name, :quantity)
  end  

  def find_order
    @order = Order.find( params[:order_id] )
  end

  def find_order_item
    @order_item = OrderItem.find( params[:id] )
  end

end
