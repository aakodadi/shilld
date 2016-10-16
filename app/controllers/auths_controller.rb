class AuthsController < ApplicationController
  before_action :set_user, only: [:create]

  # POST /auth
  def create
    if @user && @user.authenticate(user_params[:password])
      @user.remember
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /auth
  def destroy
    if current_user
      current_user.forget
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      username = user_params[:username]
      email = user_params[:email]
      unless @user = User.find_by!(username: username)
        @user = User.find_by!(email: email)
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
