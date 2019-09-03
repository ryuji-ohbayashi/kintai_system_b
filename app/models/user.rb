class User < ApplicationRecord
  # 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token # 追加 7.1.2
  before_save { self.email = email.downcase } # 4.4.6
  
  validates :name, presence: true, length: { maximum: 50 } # 4.4.1 / 4.4.3
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # 4.4.4
  validates :email, presence: true, length: { maximum: 100 }, # 4.4.2 / 4.4.3
                    format: { with: VALID_EMAIL_REGEX }, # 4.4.4
                    uniqueness: true
  has_secure_password # 4.5
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true # 4.5.1 / 追加 8.1.4
  
  #渡された文字列のハッシュ値を返します。
  def User.digest(string) # 追加 7.1.1 14~28
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember # 追加 7.1.2 32~35
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token) # 追加 7.1.3 38~40
    return false if remember_digest.nil? # 追加 7.2
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄します。
  def forget # 追加 7.1.4 43~45
    update_attribute(:remember_digest, nil)
  end
end