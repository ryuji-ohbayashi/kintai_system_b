class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] # 追加 8.2.1 / 追加 8.5.2
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy] # 追加 8.2.2 / 追加 8.4 / 追加 8.5.2
  before_action :correct_user, only: [:edit, :update] # 追加 8.2.2
  before_action :admin_user, only: :destroy
  
  def index # 追加 8.4 6~8
    @users = User.paginate(page: params[:page]) # 追加 8.4.2
  end
  
  def show
    # 5.2 3~5 # 削除 8.2.2 
  end
  
  def new
    @user = User.new # 書き換え 5.4 ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create # 5.5.2 11~18
    @user = User.new(user_params)
    if @user.save
      log_in @user # 追加 6.5 | app/assets/javascripts/application.js 追加 6.4
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user # 5.5.5
    else
      render :new
    end
  end
  
  def edit # 追加 8.1 22~24
    # 削除 8.2.2
  end
  
  def update # 追加 8.1.2 26~33
    # 削除 8.2.2
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。" # 追加 8.1.3 29~30
      redirect_to @user
    else
      render :edit
    end
  end
  
  # 追加 8.5.2 44~48
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  private # 5.5.3 20~24
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # beforeフィルター
    
    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
    
    # ログイン済みのユーザーが確認します。
    def logged_in_user # 追加 8.2.1 46~51
      unless logged_in?
      store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user # 追加 8.2.2 55~58
    # 削除 8.2.2
      redirect_to(root_url) unless current_user?(@user) # 変更 8.4
    end
    
    # システム管理権限所有かどうか判定します。
    def admin_user # 追加 8.5.2 80~82
      redirect_to root_url unless current_user.admin?
    end
end