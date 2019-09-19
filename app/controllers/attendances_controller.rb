class AttendancesController < ApplicationController
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直して下さい。" # 追加 10.6.2
  
  def update # 追加 10.5.3
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG # 書き換え 10.6.2
      end
    elsif @attendance.finished_at.nil? # 追加 10.6.2 14~18
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れさまでした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG # 書き換え 10.6.2
      end
    end
    redirect_to @user
  end
end
