class StaticPagesController < ApplicationController
  def home
    @books = Book.select_attr.page(params[:page]).per(Settings.book_per_page)
      .search params[:search]
    @categories = Category.select_attr
  end

  def help; end

  def about; end

  def contact; end
end
