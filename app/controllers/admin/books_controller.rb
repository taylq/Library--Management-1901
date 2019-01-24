module Admin
  class BooksController < BaseController
    def index
      @books = Book.select_attr.page(params[:page]).per(Settings.per_page).search params[:search]
      respond_to do |format|
        format.html
        format.csv {send_data Book.search(params[:search]).to_csv}
        format.xls {send_data Book.search(params[:search]).to_csv}
      end
    end

    def new
      @book = Book.new
      @authors = Author.select_attr
    end

    def show; end

    def create
      @book = Book.new book_params
      if @book.save
        flash[:success] = t "books.created"
      else
        flash[:danger] = t "books.create_fail"
      end
      redirect_to admin_books_path
    end

    private

    def book_params
      params.require(:book).permit :category_id, :publisher_id, :name, :content,
        :number_of_page, :status, :image, authors_books_attributes: %i(book_id author_id _destroy)
    end
  end
end
