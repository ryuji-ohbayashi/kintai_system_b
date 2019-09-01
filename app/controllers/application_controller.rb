class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 追加 6.3
end
