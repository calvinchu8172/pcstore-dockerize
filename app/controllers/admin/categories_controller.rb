class Admin::CategoriesController < Admin::BaseController
  before_action :all_categroies
  
  def index
    @q = Category.ransack(params[:q])
    @data = @q.result(distinct: true)
    @ransack_categories = @data.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find_by(id: params[:id])
  end

  def update
    @category = Category.find_by(id: params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, success: I18n.t('update_category_successful')
    else
      render :edit
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, success: I18n.t('add_category_successful')
    else
      render :new
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.soft_destroy
    redirect_to admin_categories_path, warning: I18n.t('category_deleted')
  end

  private
  
  def category_params
    params.require(:category).permit(:name)
  end

  def all_categroies
    @categories = Category.all
  end

end
