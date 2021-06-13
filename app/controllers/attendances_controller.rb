class AttendancesController < ApplicationController
  #↓追記後の状態となります。
  include AttendancesHelper
  before_action :set_user, only: [:edit_one_month, :update_one_month, :edit_attendance_up]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: [:edit_one_month, :edit_attendance_up]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
    @first_day = params[:date].to_date
    @last_day = @first_day.end_of_month
    @user = User.find(params[:id])
    @attendance = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    #debugger
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "当月分勤怠データ.csv", type: :csv
      end
    end
  end

  def update_one_month
   # debugger
    ActiveRecord::Base.transaction do
      if attendances_invalid?
        attendances_params.each do |id, item|
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
        flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
        redirect_to user_url(date: params[:date])
      else
        flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end

  def edit_attendance_log
    @user = User.find(params[:id])
    @users = User.find(params[:id])
    @userall = User.all
    @notice_users = User.where(id: @user.id)
    if params["data(1i)"] == nil
      @first_day = params[:date].nil? ?
      Date.current.beginning_of_month : params[:date].to_date
      @last_day = @first_day.end_of_month
      one_month = [*@first_day..@last_day] 
      @attendance1 = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
      @attendances = @attendance1.where(confirmation_change: @user.name)
      @attendances_list = @attendance1.where(user_id: params[:id])
      @notices1 = @attendances_list.where(confirmation_change: @user.name)
      @notices = @notices1.where(confirmation_change_status: "承認").where(change_attendance: true)
      #debugger
    else 
      date = params["data(1i)"].to_s + '-' + "%02d" %params["data(2i)"].to_s + '-01'
      search_date = date.to_date.beginning_of_month
      @attendance1 = User.find(params[:id]).attendances.where(worked_on: search_date.beginning_of_month.in_time_zone.all_month).order(:worked_on)
      @attendances_list = @attendance1.where(user_id: params[:id])
      @notices1 = @attendances_list.where(confirmation_change: @user.name)
      @notices = @notices1.where(confirmation_change_status: "承認").where(change_attendance: true)
    end
  end

  # 残業申請のモーダル
  def edit_overtime_request
    @attendance = User.find(params[:user_id]).attendances.find(params[:id])
    @user = User.find(@attendance.user_id)
    #debugger
  end

  def update_overtime_request
    @attendance = Attendance.find(params[:id])
    @user = User.find(@attendance.user_id)
    if @attendance.update_attributes(overtime_params)
      #debugger
      flash[:success] = "残業を申請しました。"
    else
      flash[:danger] = "申請に失敗いたしました。"
    end
    redirect_to @user
  end

  def edit_notice_overtime
    @user = User.find(params[:id])
    @users = User.find(params[:user_id])
    @attendance_id = Attendance.where(confirmation_id_zangyou: @users.id)
    @notice_users = User.where(id: @attendance_id.where(change: nil).or(@attendance_id.where(change: false)).or(@attendance_id.where(overtime_status: "申請中")).select(:user_id))
    @attendances_list = Attendance.where.not(user_id: params[:id])
    @notices = @attendances_list.where.not(scheduled_end_time: nil)
    @notices_to = @notices.where(confirmation_id_zangyou: @users.id)
    #debugger
  end

  def update_notice_overtime
    @users = User.find(params[:user_id])
    update_notice_params.each do |id, item|
    attendance = Attendance.find(id)
    attendance.update_attributes!(item)
      if attendance.change == true
        flash[:success] = "残業申請のお知らせを変更しました。"     
      else 
        flash[:danger] = "申請内容に不備があるため変更に失敗しました。" 
      end
    end   
    redirect_to @users
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  def edit_attendance_up
    @user = User.find(params[:id])
    @users = User.find(params[:user_id])
    @attendances = Attendance.where(confirmation_id: params[:user_id])
    @notice_users = User.where(id: @attendances.where(change_attendance: nil).or(@attendances.where(change_attendance: false)).or(@attendances.where(confirmation_change_status: "申請中")).select(:user_id))
    @attendances_list = Attendance.where.not(user_id: params[:id])
    @notices1 = @attendances_list.where.not(confirmation_change: @users.name)
    @notices = @notices1.where(confirmation_id: params[:id]).where(change_attendance: nil).or(@notices1.where(confirmation_id: params[:id]).where(change_attendance: false))
    @notices_count = @notices.where(confirmation_id: params[:id]).count
  end

  def update_attendance_up
    @users = User.find(params[:id])
    update_attendance_up_params.each do |id, item|
    attendance = Attendance.find(id)
    attendance.update_attributes!(item)
      if attendance.change_attendance == true
        #debugger
        flash[:success] = "残業申請のお知らせを変更しました。"     
      else 
        flash[:danger] = "申請内容に不備があるため変更に失敗しました。" 
      end
    end 
    redirect_to @users
  end

  def edit_one_month_show
    @users = User.all
    @first_day = params[:worked_on].to_date
    @last_day = @first_day.end_of_month
    @user = User.find(params[:id])
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    @worked_sum = @attendances.where.not(started_at: nil).or(@attendances.where(confirmation_change_status: "承認")).count
    #debugger 
  end

  private

    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:before_started_at, :before_finished_at, :confirmation_id, :note, :confirmation_change, :confirmation_change_status, :next_day2])[:attendances]
    end

    def overtime_params
      params.require(:attendance).permit(:scheduled_end_time, :next_day, :business_process, :confirmation, :overtime_status, :confirmation_id_zangyou)
    end

    def update_attendance_up_params
      params.require(:user).permit(attendances: [:confirmation_change_status, :change_attendance])[:attendances]
    end

    def update_notice_params
      params.require(:user).permit(attendances: [:overtime_status, :change])[:attendances]
    end

    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
end