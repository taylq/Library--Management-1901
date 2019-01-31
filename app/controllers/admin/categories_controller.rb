module Admin
  class CategoriesController < BaseController
    before_action :find_category, only: %i(update destroy)

    def index
      @categories = Category.select_attr.order_comment.page(params[:page])
        .per(Settings.per_page).search params[:search]
      @category = Category.new
    end

    def update
      if @category.update category_params
        flash[:success] = t "categories.update_success"
      else
        flash[:danger] = t "categories.update_fail"
      end
      redirect_to admin_categories_path
    end

    def create
      @category = Category.new category_params
      if @category.save
        flash[:success] = t "categories.create_successfully"
      else
        flash[:danger] = t "categories.create_fail"
      end
      redirect_to admin_categories_path
    end

    def destroy
      if @category.destroy
        flash[:success] = "categories.destroy_successfully"
      else
        flash[:danger] = "categories.destroy_fail"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit :name
    end

    def find_category
      return if @category = Category.find_by(id: params[:id])
      flash[:danger] = "categories.find_fail"
      redirect_to admin_categories_path
    end
  end
end
