class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :load_post, only: :show

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t ".created"
      redirect_to root_url
    else
      flash.now[:danger] = t ".fail_create"
      @feed_items = []
      render "static_pages/home"
    end
  end

  def show
    @comments = @micropost.comments
      .select(:id, :user_id, :micropost_id, :content, :created_at)
      .order(created_at: :asc)
    @user = User.find_by id: @micropost.user_id
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def load_post
    @micropost = Micropost.find_by id: params[:id]
  end

  def micropost_params
    params.require(:micropost).permit :title, :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
