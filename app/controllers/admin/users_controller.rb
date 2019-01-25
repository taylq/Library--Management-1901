module Admin
  class UsersController < BaseController
    before_action :find_user, except: %i(index new create)

    def index
      @users = User.select_attr.page(params[:page]).per(Settings.per_page).search params[:search]
      respond_to do |format|
        format.html {}
        format.csv { send_data User.search(params[:search]).to_csv }
        format.xls { send_data User.search(params[:search]).to_csv }
      end
    end

    def new
      @user = User.new
    end

    def show; end

    def edit; end

    def update
      if @user.update user_params
        flash[:success] = t "users.update_success"
      else
        flash[:danger] = t "users.update_fail"
      end
      redirect_to admin_users_path
    end

    def create
      @user = User.new user_params
      if @user.save
        log_in @user
        flash[:success] = t "users.welcome"
        redirect_to @user
      else
        render :new
      end
    end

    def destroy
      if @user.destroy
        flash[:success] = t "users.delete_success"
      else
        flash[:danger] = t "users.delete_fail"
      end
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation, :role
    end

    def find_user
      return if @user = User.find_by(id: params[:id])
      flash[:danger] = t "books.find_fail"
      redirect_to users_path
    end
  end
end
