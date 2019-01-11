class BooksController < ApplicationController
  before_action :find_book, except: %i(index)

  def index
    @books = Book.select_attr.page(params[:page]).per(Settings.book_per_page)
      .search params[:search]
    @categories = Category.select_attr
  end

  def show; end

  private

  def find_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t "books.find.fail"
    redirect_to books_path
  end
end
