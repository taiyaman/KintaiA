class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info, :index_attendance, :user_basic_update, :index]
  before_action :set_one_month, only: :show
  before_action :admin_or_correct_user, only: :show
  
  def user_basic_update
  end
  
  def index
    @users = User.all 
    @user = User.find("1")
  end

  def import
    if params[:file].blank?
      flash[:warning] = "CSVファイルが選択されておりません"
      redirect_to users_url
    else
      User.import(params[:file])
      flash[:success] = "インポートに成功しました。"
      redirect_to users_url
    end
  end
  
  def show
    if params[:id] == "1"
      redirect_to root_url 
    else
      @user = User.find(params[:id])
      @users = User.all
      @apply1 = Apply.all.where(authorizer: params[:id]) #申請件数を表示
      @applies = @apply1.group(:month)
      @applies3 = @apply1.group(:month).group(:user_name)
      #@applies_test = @apply1.select(:month,:user_name, :authorizer_name).distinct
      #@applies_group = @applies3.where(change: false).or(@applies3.where(change: nil))
      #@applies_count = @applies_group.sum(:month).count
      @applies_count1 = @apply1.where(change: nil).count
      @applies_count2 = @apply1.where(change: false).count
      @applies_count = @applies_count1 + @applies_count2 
      #debugger
      @apply2 = Apply.all.where(user_name: User.find(params[:id]).name)
      @applies2 = @apply2.group(:month)
      @oneday = @user.attendances.where(worked_on: @first_day).order(:worked_on)
      @attendances_list = Attendance.where.not(user_id: params[:id])
      @notices = @attendances_list.where.not(scheduled_end_time: nil)
      @notices_toA_sum_test = @notices.where(confirmation_id_zangyou: 2)
      @notices_toA_sum2 = @notices_toA_sum_test.where(overtime_status: "申請中").or(@notices_toA_sum_test.where(change: false)).or(@notices_toA_sum_test.where(change: nil)).count
      @notices_toB_sum_test = @notices.where(confirmation_id_zangyou: 3)
      @notices_toB_sum2 = @notices_toB_sum_test.where(overtime_status: "申請中").or(@notices_toB_sum_test.where(change: false)).or(@notices_toB_sum_test.where(change: nil)).count
      @notices1 = @attendances_list.where.not(confirmation_change: @users.name)
      @notices2 = @notices1.where(change_attendance: nil).or(@notices1.where(confirmation_change_status: "申請中"))
      @notices_count = @notices2.where(confirmation_id: params[:id]).count
      @worked_sum1 = @attendances.where(change_attendance: true).or(@attendances.where.not(started_at: nil)).count
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    
    redirect_to users_url
  end

  def index_attendance
    @users = User.all.includes(:attendances)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :employee_number, :uid, :password, :basic_time, :work_start_time, :work_end_time)
    end

    def basic_info_params
      params.require(:user).permit(:name, :email, :department, :employees_number, :uid, :password, :basic_time, :defalut_work_start_time, :defalut_work_end_time)
    end

    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "権限がありません。"
        redirect_to(root_url)
      end  
    end
end