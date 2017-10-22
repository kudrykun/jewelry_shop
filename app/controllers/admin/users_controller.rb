class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_password, :update_password]
  # если текущий пользователь не админ, то запретить: создание нового пользователя
  before_action :not_admin, only: [:new, :create, :index, :destroy]
  # если пользователь не админ и не просматриваемый пользователь , то запретить: просмотр, удаление, обновление
  before_action :not_admin_current_user, only: [:show, :edit, :update, :edit_password, :update_password, :destroy]
  # если пользователь админ и не просматриваемый пользователь , то запретить: просмотр, удаление, обновление
  before_action :is_admin_not_current_user, only: [:edit, :update, :edit_password, :update_password]
  def index
    @users = User.all.where.not(id: current_user.id).order(admin: :desc).to_a
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    # Генерация пароля из 8 символов. TODO это еще нужно совместить с confirmation
    @user.password = Devise.friendly_token.first(8)
    if @user.save
      record_activity(@user)
      redirect_to admin_user_path(@user), notice: 'Пользователь был добавлен.'
    else
      render :new
    end
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
    @user_tmp = @user.dup
    @user.destroy
    record_activity(@user_tmp)
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
  def not_admin
    if !current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  def not_admin_current_user
    if current_user != @user && !current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  def is_admin_not_current_user
    if current_user != @user && current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :second_name, :password, :password_confirmation, :current_password)
  end
end
