class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_password, :update_password]

  def index
    @users = User.all.where.not(id: current_user.id).to_a
  end

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

  def destroy
    if !@user.picture.nil?
      @user.picture.destroy
    end
    @user.destroy
    redirect_to admin_users_url, notice: 'Пользователь был успешно удален.'
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
    params.require(:user).permit(:first_name, :second_name, :password, :password_confirmation, :current_password)
  end
end
