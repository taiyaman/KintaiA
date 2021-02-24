class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  before_action :admin_or_correct_user, only: :show
  
  #def index
  #  @users = User.paginate(page: params[:page])
  #end
  
  #def index
    #条件分岐
    #@users = if params[:search]
    #searchされた場合は、原文+.where('name LIKE ?', "%#{params[:search]}%")を実行
    #User.where(activated: true).paginate(page: params[:page]).where('name LIKE ?', "%#{params[:search]}%")
    #@users = User.paginate(page: params[:page]).search(params[:search])
    #@users = User.paginate(page: params[:page]).where('name LIKE ?', "%#{params[:search]}%")
    #User.search("search")
    #if params[:search].blank?
    #else
    #searchされていない場合は、原文そのまま
    #  User.paginate(page: params[:page])
    #@users = User.where(activated: true).paginate(page: params[:page]).search(params[:search])
    #end
  #end

  def index
    @users = User.all
  end

  # def index
  #   @users = User.all
  # end

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
    @attendances_list = Attendance.where(name: current_user.name).where.not(user_id: params[:id])
    @worked_sum = @attendances.where.not(started_at: nil).count
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
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
  end