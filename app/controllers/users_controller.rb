class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :reservations]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy, :reservations]
  before_action :not_logged_in_user, only: [:new]
  before_action :correct_user, only: [:edit, :update, :reservations]
  before_action :admin_user, only: [:destroy, :all_reservation, :reservations_list, :index]
  before_action :correct_or_admin_user, only: [:show]

  def index
    @users = User.paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end


  def show
  end

  def reservations
    @reservations = Reservation.all.where(user_id: @user.id).where("day >= ?", Date.current)
  end

  def reservations_list
    @stores = Store.all
  end

  def all_reservation
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    @stores = Store.all
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def not_logged_in_user
      if logged_in?
        flash[:danger] = "既にログイしてます。"
        redirect_to root_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def correct_or_admin_user
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
end
