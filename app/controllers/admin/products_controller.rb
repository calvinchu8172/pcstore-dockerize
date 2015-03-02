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
      redirect_to admin_products_path, notice: '成功更新商品'
    else
      render :edit
    end 
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: '成功新增商品'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.set_delete
    redirect_to admin_products_path, notice: '商品已刪除'
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :is_online, :image)
  end

end
