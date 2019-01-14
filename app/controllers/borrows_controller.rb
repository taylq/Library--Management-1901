class BorrowsController < ApplicationController

  def index
    @borrows = current_user.borrows.all
  end

  def new; end

  def create
    @borrow = Borrow.new borrow_params
    if @borrow.save
      log_in @borrow
      flash[:success] = t "borrows.created"
      redirect_to user_borrows_path current_user
    else
      render :new
    end
  end

  private

  def borrow_params
    params.require(:borrow).permit :user_id, :book_id, :started_at, :finished_at, :status
  end
end
