class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to dashboard_path, notice: "User was successfully created."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_user_params)
      redirect_to dashboard_path, notice: "User was successfully updated."
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:username)
  end
end
