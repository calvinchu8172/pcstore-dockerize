class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
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
      redirect_to admin_categories_path, notice: '成功更新分類'
    else
      render :edit
    end 
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: '成功新增商品'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy
    redirect_to admin_categories_path, notice: '商品已刪除'
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
