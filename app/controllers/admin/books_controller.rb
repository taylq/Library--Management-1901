module Admin
  class BooksController < BaseController
    before_action :find_book, except: %i(index create new)

    def index
      @q = Book.ransack params[:q]
      @books = @q.result(distinct: true).page(params[:page]).per Settings.per_page
      respond_to do |format|
        format.html
        format.csv {send_data Book.ransack(name_or_content_or_publisher_name_or_authors_name_cont: params[:q])
          .result(distinct: true).to_csv}
        format.xls {send_data Book.ransack(name_or_content_or_publisher_name_or_authors_name_cont: params[:q])
          .result(distinct: true).to_csv}
      end
    end

    def new
      @book = Book.new
      @authors = Author.select_attr
    end

    def show; end

    def edit
      @authors = Author.select_attr
    end

    def update
      if @book.update book_params
        flash[:success] = "update_success"
        redirect_to admin_books_path
      else
        flash[:danger] = "update_fail"
        render :edit
      end
    end

    def destroy
      if @book.destroy
        flash[:success] = "destroy_succsess"
      else
        flash[:danger] = "destroy_fail"
      end
      redirect_to admin_books_path
    end

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
        :number_of_page, :status, :image, authors_books_attributes: %i(id book_id author_id _destroy)
    end

    def find_book
      return if @book = Book.find_by(id: params[:id])
      flash[:danger] = t "books.find_fail"
      redirect_to admin_books_path
    end
  end
end
