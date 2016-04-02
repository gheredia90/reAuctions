class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update] # probably want to keep using this
  
  def home
    title = params[:title]
    if current_user.role == 'Buyer'
      @my_rfps = current_user.rfps_as_buyer(title)
      @my_auctions = current_user.auctions_as_buyer 
      render 'buyer_dashboard'
    else
      @available_rfps = current_user.rfps_available_as_supplier
      @available_auctions = current_user.auctions_available_as_supplier
      render 'supplier_dashboard'
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
 
  # # GET /users/1
  # # GET /users/1.json
  def show
    @user = current_user 
  end
 
  # GET /users/1/edit
  def edit
 
  end

  
  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:role, :user_name)
    end
 
end
