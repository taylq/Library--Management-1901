class BorrowsController < ApplicationController
  before_action :find_borrow, only: :destroy

  def index
    @borrows = current_user.borrows.select_attr.page(params[:page]).per Settings.book_per_page
  end

  def new; end

  def create
    if Borrow.check_record(params[:borrow][:user_id], params[:borrow][:book_id]).present?
      flash[:danger] = t "borrows.already_exist"
      redirect_to books_path
    else
      create_borrow
    end
  end

  def destroy
    if @borrow.destroy
      flash[:success] = "borrows.delete_successfully"
    else
      flash[:danger] = "borrows.delete_fail"
    end
    redirect_to user_borrows_path
  end

  private

  def borrow_params
    params.require(:borrow).permit :user_id, :book_id, :started_at,
      :finished_at, :status
  end

  def find_borrow
    return if @borrow = Borrow.find_by(id: params[:id])
    flash[:danger] = t "users.find_fail"
    redirect_to user_borrows_path
  end

  def create_borrow
    @borrow = Borrow.new borrow_params
    if @borrow.save
      flash[:success] = t "borrows.created"
      redirect_to book_path @borrow.book
    else
      flash[:danger] = t "borrows.created_fail"
      redirect_to books_path
    end
  end
end
