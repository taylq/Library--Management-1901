module Admin
  class BorrowsController < BaseController
    before_action :find_borrow, :find_book, only: :update

    def index
      @borrows = Borrow.select_attr.search params[:status], params[:search]
    end

    def update
      if @borrow.update_attributes borrow_params
        flash[:success] = t "update_success"
        update_book_and_other_borrow
      else
        flash[:danger] = t "update_fail"
      end
      redirect_to admin_borrows_path
    end

    private

    def borrow_params
      params.require(:borrow).permit :user_id, :book_id, :started_at,
        :finished_at, :status
    end

    def update_book_and_other_borrow
      if params[:borrow][:status] == Settings.approved
        @book.update_attributes status: Book.statuses[:borrowed]
        @borrows = Borrow.find_by_status @book.id, @borrow.finished_at
        @borrows.update status: Settings.disapproved
      elsif params[:borrow][:status] == Settings.done
        @book.update_attributes status: Book.statuses[:ready]
      end
    end

    def find_borrow
      return if @borrow = Borrow.find_by(id: params[:id])
      flash[:danger] = t "borrow.find.fail"
      redirect_to admin_borrows_path
    end

    def find_book
      return if @book = Book.find_by(id: @borrow.book_id)
      flash[:danger] = t "book.find.fail"
      redirect_to admin_borrows_path
    end
  end
end
