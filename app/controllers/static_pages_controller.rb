class StaticPagesController < ApplicationController
  def home
    @books = Book.select_attr.page(params[:page]).per(Settings.book_per_page)
      .search params[:search]
    @categories = Category.select_attr
    return unless logged_in?
    @categories = current_user.categories_of_feed
    @books = current_user.feed.page(params[:page]).per(Settings.book_per_page)
      .search params[:search]
  end

  def help; end

  def about; end

  def contact; end
end
