class UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all.paginate(page: params[:page], per_page:10)
  end

  def show
  end

  def edit 
    @user = User.find(user_params[:id])
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: 'Access denied' unless current_user.admin?
  end

  def user_params
    require(:user).permit(:id, :first_name, :lastname, :role, :status)
  end




end