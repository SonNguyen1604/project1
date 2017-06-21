class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".login_first"
    redirect_to login_url
  end

  def valid_info object
    render file: "public/404.html", layout: false unless object
  end
end
