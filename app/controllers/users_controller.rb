class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]) # 5.2 3~5 
  end
  
  def new
    @user = User.new # 書き換え 5.4 ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create # 5.5.2 11~18
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user # 5.5.5
    else
      render :new
    end
  end
  
  private # 5.5.3 20~24
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
