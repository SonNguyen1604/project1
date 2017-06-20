class UsersController < ApplicationController
  before_action :load_user, except: [:new, :create, :index]
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :verify_admin, only: :destroy
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.select(:id, :name, :email).id_sort
      .paginate page: params[:page], per_page: Settings.user.per_page
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      flash.now[:danger] = t ".fail_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".fail_delete"
    end
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    valid_info @user
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
