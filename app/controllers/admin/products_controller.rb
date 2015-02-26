class Admin::ProductsController < Admin::BaseController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, notice: '成功新增商品'
      else
        render :new
      end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :is_online, :image)
  end

end
