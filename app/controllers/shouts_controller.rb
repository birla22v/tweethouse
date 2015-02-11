class ShoutsController < ApplicationController
 before_action :set_user
 before_action :set_shout, only: [:show, :destroy, :update, :edit]


  def index
    @shouts = @user.shouts
  end

  def new
    @shout = Shout.new
  end

  def create
    @shout = @user.shouts.create(shout_params)
    respond_to do |format|
      if @shout.valid?
        format.html {redirect_to [@user, @shout], notice: "shout created"}
        format.json {render :show, status: :created, location: @shout}
      else
        format.html {render :new, notice: "unable to create shout, please try again"}
        format.json {render json: @shout.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
    respond_to do |format|
      format.html {render :show}
      format.json {@shout.to_json}
    end
  end

  def edit
    render :edit
  end

  def update
    @shout = @user.shouts.find_by_id(params[:id])
    @shout.update_attributes(shout_params)
    respond_to do |format|
      if @shout.save
        format.html {redirect_to [@user, @shout], notice: "shout updated"}
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
      format.html {redirect_to user_shouts_path(@user), notice: "shout deleted"}
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