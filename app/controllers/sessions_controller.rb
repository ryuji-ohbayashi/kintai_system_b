class SessionsController < ApplicationController
  def new
  end
  
  def create #  追加 6.2.2 5~7
    user = User.find_by(email: params[:session][:email].downcase) # 追加 6.2.2 6~12
    if user && user.authenticate(params[:session][:password])
      log_in user # 追加 6.3.1 8~9
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) # 追加 7.1.4 / 変更 7.3
      redirect_back_or user
    else
      flash.now[:danger] = '認証に失敗しました。' # 追加 6.2.3
      render :new
    end
  end
  
  def destroy # 追加 6.6 16~20
    log_out if logged_in? # 追加 7.2
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
