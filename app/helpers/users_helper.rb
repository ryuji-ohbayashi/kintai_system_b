module UsersHelper
  
  # 勤怠基本情報を指定のフォーマットで返します。
  def format_basic_info(time) # 追加 9.2.3 4~6
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
end
