class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path, success: I18n.t('update_product_successful')
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, success: I18n.t('add_product_successful')
    else
      render :new
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to admin_products_path, warning: I18n.t('product_deleted')
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :is_online, :image, :category_id)
  end

end
