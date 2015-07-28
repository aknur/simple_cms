class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:admin]
  
  def admin
       # Показываем содержимое admin.html.erb
  end
  
  def login
      # login форма
  end
  
  def attempt_login
      if params[:email].present? && params[:password].present?
        found_user = User.find_by_email(params[:email])
        if found_user
          authorized_user = found_user.authenticate(params[:password])
        end
      end
  
      if authorized_user
        # mark user as logged in
        session[:user_id] = authorized_user.id
        session[:name] = authorized_user.name
        flash[:success] = "Вы успешно вошли."
        redirect_to(action: 'admin')
      else
        flash[:danger] = "Неверное имя/пароль."
        redirect_to(:action => 'login')
      end
  end
  
  def logout
      # удаление текущей сессии
      session[:user_id] = nil
      session[:name] = nil
      flash[:success] = "Вы успешно"
      redirect_to(:action => "login")
     # попытка входа
  end
  
  def index
     @users = User.all
  end
  
  def new
      @user = User.new
  end
  
  def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Добро пожаловать в Simple CMS!"
        session[:user_id] = @user.id
        session[:name] = @user.name
        redirect_to @user
      else
        render 'new'
      end
  end
    def show
     @user = User.find(params[:id])
    end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Пользователь обновлен"
        redirect_to @user
      else
        render 'edit'
      end
  end
  
    private
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  
  end


