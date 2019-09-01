module SessionsHelper
  
  #引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user) # 追加 6.3.1
    session[:user_id] = user.id
  end
  
  # セッションと@current_userを破棄します
  def log_out # 追加 6.6 9~12
    session.delete(:user_id)
    @current_user = nil
  end
  
  #現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user #追加 6.3.2 9~13
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  #現在ログイン中びユーザーがいればtrue, そうでなければfalseを返します。
  def logged_in? # 追加 6.4 16~18
    !current_user.nil?
  end
end
