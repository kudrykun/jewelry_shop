class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :edit_password, :update_password]

  def show
  end

  def edit
  end

  def update
    if params[:picture]
      #удаляем старое изображение
      if !@user.picture.nil?
        @user.picture.destroy
      end
      # добавляем новое
      picture = Picture.create(image: params[:picture])
      @user.picture = picture
    end
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'Пользователь был успешно обновлен.'
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to admin_user_path(@user), notice: 'Пароль был успешно обновлен.'
    else
      render :edit_password
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :second_name, :username, :password, :password_confirmation, :current_password)
  end
end
