class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update] # probably want to keep using this
  
  def home
    title = params[:title]
    gon.role = current_user.role
    if current_user.role == 'Buyer'
      @my_rfps = current_user.rfps_as_buyer(title)
      @my_auctions = current_user.auctions_as_buyer 
      render 'buyer_dashboard'
    else
      @my_rfps = current_user.rfps_available_as_supplier(title)
       @my_auctions = current_user.auctions_available_as_supplier
      render 'supplier_dashboard'
    end
  end
  
  def index
    @users = User.all
  end 
  
  def show
    @user = current_user 
  end 
  
  def edit 
  end  
 
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
    @user = User.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:role, :category, :user_name)
  end
 
end
