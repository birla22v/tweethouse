class ShoutsController < ApplicationController
 before_action :set_user
 before_action :set_shout, only: [:show, :destroy, :update, :edit]
 before_action :authenticate_user!, :only => [:destroy, :new, :create, :update, :show]


  def index
    @shouts = @user.shouts
  end

  def new
    @shout = Shout.new
  end

  def create
    if current_user
      @shout = current_user.shouts.create(shout_params)
      respond_to do |format|
        if @shout.valid?
          format.html {redirect_to user_shouts_path, notice: "shout created"}
          format.json {render :show, status: :created, location: @shout}
        else
          format.html {render :new, notice: "unable to create shout, please try again"}
          format.json {render json: @shout.errors, status: :unprocessable_entity}
        end
      end
    else
      flash[:alert] = "your only allowed to create shouts for yourself."
    end
  end

  def show
    respond_to do |format|
      format.html {render :show}
      format.json {@shout.to_json}
    end
  end

  def edit
    if current_user.id == @shout.user_id  
      render :edit 
    else
      flash[:alert] = "you cant edit a shout thats not your own."
    end
  end

  def update
    @shout = current_user.shouts.find_by_id(params[:id])
    @shout.update_attributes(shout_params)
    respond_to do |format|
      if @shout.save
        format.html {redirect_to [current_user, @shout], notice: "shout updated"}
        format.json {render :show, status: :created, location: @shout}
      else
        format.html {render :show, notice: "unable to update shout, please try again"}
        format.json {render json: @shout.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @shout.destroy
    respond_to do |format|
      format.html {redirect_to user_shouts_path(current_user), notice: "shout deleted"}
      format.json {render json: @shout.to_json, status: :deleted}
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shout
    @shout = Shout.find(params[:id])
  end

  def shout_params
    params.require(:shout).permit(:body)
  end

end