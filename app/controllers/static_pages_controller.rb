class StaticPagesController < ApplicationController
  def home
    @q = Book.ransack params[:q]
    @books = @q.result(distinct: true).page(params[:page]).per Settings.book_per_page
    @categories = Category.select_attr
  end

  def help; end

  def about; end

  def contact; end
end
