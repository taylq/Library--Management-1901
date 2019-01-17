class BorrowsController < ApplicationController

  def index
    @borrows = current_user.borrows.select_attr
  end

  def new; end

  def create
    if Borrow.check_record(params[:borrow][:user_id], params[:borrow][:book_id]).present?
      flash[:danger] = t "borrows.already.exist"
      redirect_to books_path
    else
      create_borrow
    end
  end

  private

  def borrow_params
    params.require(:borrow).permit :user_id, :book_id, :started_at,
      :finished_at, :status
  end

  def create_borrow
    @borrow = Borrow.new borrow_params
    if @borrow.save
      flash[:success] = t "borrows.created"
      redirect_to book_path @borrow.book
    else
      flash[:danger] = t "borrows.created.fail"
      redirect_to books_path
    end
  end
end
