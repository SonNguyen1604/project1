class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      alert = t ".login_success"
      alert += user.name
      flash[:success] = alert
      "1" == params[:session][:remember_me] ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:danger] = t ".fail_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".logout"
    redirect_to root_url
  end
end
