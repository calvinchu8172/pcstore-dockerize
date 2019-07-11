class Admin::ProductsController < Admin::BaseController
  before_action :all_categroies

  def index
    @q = Product.ransack(params[:q])
    @data = @q.result(distinct: true)

    if params[:category]
      @products = @data.where(category_id: params[:category]).page(params[:page]).per(10)

    else
      @products = @data.page(params[:page]).per(10)
    end 
  end

  def show
    @product = Product.find_by(id: params[:id])
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
      redirect_to admin_product_path(@product), success: I18n.t('update_product_successful')
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
    @product = Product.unscoped.find_by(id: params[:id])
    @product.destroy
    redirect_to :back, warning: I18n.t('product_deleted')
  end

  def recycle
    @product = Product.find_by(id: params[:id])
    @product.recycle
    redirect_to admin_products_path, warning: I18n.t('product_recycled')
  end 

  def unrecycle
    @product = Product.unscoped.find_by(id: params[:id])
    @product.unrecycle
    redirect_to recycled_admin_products_path, warning: I18n.t('product_unrecycled')
  end

  def recycled
    @products = Product.unscoped.where(is_recycled: true)
  end

  private

  def all_categroies
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :is_online, :image, :category_id)
  end

end
