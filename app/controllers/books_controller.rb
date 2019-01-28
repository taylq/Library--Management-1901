class BooksController < ApplicationController
  before_action :find_book, except: %i(index)
  before_action :status_follow_book, :status_like_book, only: %i(show)

  def index
    @books = Book.select_attr.search(params[:search]).uniq
    @panigatable = Kaminari.paginate_array(@books).page(params[:page]).per Settings.book_per_page
    @categories = Category.select_attr
    respond_to do |format|
      format.html {}
      format.csv { send_data Book.search(params[:search]).to_csv }
      format.xls { send_data Book.search(params[:search]).to_csv }
    end
  end

  def show
    @comments = @book.comments.order_comment
    return unless user_signed_in?
    @borrow = current_user.borrows.new
    @comment = current_user.comments.build
  end

  private

  def find_book
    return if @book = Book.find_by(id: params[:id])
    flash[:danger] = t "books.find_fail"
    redirect_to books_path
  end

  def status_follow_book
    return unless user_signed_in?
    @follow_book = @book.follow_books.find_by(book_id: @book.id) || @book.follow_books.build
  end

  def status_like_book
    return unless user_signed_in?
    @like_book = @book.like_books.find_by(book_id: @book.id) || @book.like_books.build
  end
end
