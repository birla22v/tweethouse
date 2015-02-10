class ShoutsController < ApplicationController
 before_action :set_shout, only: [:show, :edit, :update, :destroy, :post]
 #before_action :set_user, only: [:show, :edit, :update, :destroy, :post]


  def index
    @shouts = Shout.all
  end

  def new
    @shout = Shout.new
    #binding.pry
    render :new
  end

  def create
    binding.pry
    @shout = Shout.create(shout_params)
    @shout.user_id = params[:user_id]
    respond_to do |format|
      if @shout
        format.html {redirect_to @shout, notice: "shout created"}
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

  def destroy
    @shout.destroy
  end

  private

  #def set_user
  #  @user = User.first
  #end

  def set_shout
    @shout = Shout.find(params[:user_id])
  end

  def stub_id
    rand(Shout.count) + 1
  end

  def shout_params
    params.require(user).permit(:shout)
  end


end