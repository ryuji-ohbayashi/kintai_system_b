module SessionsHelper
  
  #引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user) # 追加 6.3.1
    session[:user_id] = user.id
  end
  
  # 永続的セッションを記憶します（Userモデルを参照）
  def remember(user) # 追加 7.1.3 9~13
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 永続的セッションを破棄します
  def forget(user) # 追加 7.1.4 16~20
    user.forget # Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # セッションと@current_userを破棄します
  def log_out # 追加 6.6 9~12
  forget(current_user) # 追加 7.1.4
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 一時的セッションにいるユーザーを返します。
  #現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user # 追加 6.3.2 9~13 / 変更 7.1.3 23~32
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # 渡されたユーザーがログイン済みのユーザーであればtrueを返します。
  def current_user?(user) # 追加 8.2.2 44~46
    user == current_user
  end
  
  # 現在ログイン中びユーザーがいればtrue, そうでなければfalseを返します。
  def logged_in? # 追加 6.4 16~18
    !current_user.nil?
  end
  
  # 記憶しているURL(またはデフォルトURL)にリダイレクトします。
  def redirect_back_or(default_url) # 追加 8.3 54~57
    redirect_to(session[:forwarding_url] || default_url)
    session.delete(:forwarding_url)
  end
  
  # アクセスしようとしたURLを記憶します。
  def store_location # 追加 8.3 60~62
    session[:forwarding_url] = request.original_url if request.get?
  end
end
