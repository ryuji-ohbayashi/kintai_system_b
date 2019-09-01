class SessionsController < ApplicationController
  def new
  end
  
  def create #  追加 6.2.2 5~7
    user = User.find_by(email: params[:session][:email].downcase) # 追加 6.2.2 6~12
    if user && user.authenticate(params[:session][:password])
      log_in user # 追加 6.3.1 8~9
      redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。' # 追加 6.2.3
      render :new
    end
  end
  
  def destroy # 追加 6.6 16~20
    log_out
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
