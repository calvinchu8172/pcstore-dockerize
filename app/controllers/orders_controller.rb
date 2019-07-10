class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, except: :index
  before_action :ignore_other_params_if_id_exists, only: :index

  def index
    params[:q] = ignore_other_params_if_id_exists

    @q = current_user.orders.ransack(params[:q])
    @data = @q.result(distinct: true)
    @orders = @data.page(params[:page]).per(20)
    
    if @orders.count == 0
      flash[:notice] = I18n.t('order.no_order')
    end 
  end

  def show
  end

  def edit
  end

  def update
    if @order.update_attributes( order_params )
      @order.sum = @order.total_price
      @order.save
      redirect_to order_path(@order), success: I18n.t('order.update.success')
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, order_items_attributes: [:id, :quantity], receipt_attributes: [:name, :tel, :country, :city, :address])
  end

  def find_order
    @order = Order.find( params[:id] )
  end

  def ignore_other_params_if_id_exists
    if params[:q]
      unless params[:q]['id_eq'].blank?
        params[:q].delete_if {|key, value| key != 'id_eq' }
      end
    end
  end

end