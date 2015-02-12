
class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:destroy]
  before_action :set_user, :only => [:following, :destroy, :followers, :follow, :unfollow]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to new_user_session
  end

  def index
    #@users = User.all
  #  @users = Kaminari.paginate_array(User.order("username").page(params[:page]))
    # myarray = User.all
    # @users = Kaminari.paginate_array(myarray).page(params[:page])
    # @users = User.order("name").page(params[:page])
    # @users = User.order(:username).page params[:page]
    # @users = User.paginate_array(User.all).page(params[:page]).per(5)
    @users = User.paginate(:page => params[:page], :per_page => 5).order('username desc')

    end

  def destroy
      if current_user == @user
        @user.destroy
        redirect_to root_path, notice: "User deleted."
      else
        flash[:alert]="You can only delete your own account"
        redirect_to root_path
      end
  end

  def followers
    @follow_list = @user.followers
  end

  def following
    @follow_list = @user.following
  end

  def follow
    if current_user != @user && @user.private == false
      current_user.follow!(@user)
    else
      flash[:alert] = "Can't do that"
    end
   redirect_to :back
  end

  def unfollow
    if current_user != @user
      current_user.unfollow!(@user)
    else
      flash[:alert] = "Can't do that"
    end
   redirect_to :back
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

end
