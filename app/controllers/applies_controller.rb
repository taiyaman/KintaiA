class AppliesController < ApplicationController
    before_action :set_one_month, only: :show
    
    def create
        @user = User.find(params[:user_id])
        @apply = @user.applies.create(apply_params)
        # debugger
        if @apply.update_attributes!(apply_params)
            flash[:success] = "ユーザー情報1を更新しました。"
            redirect_to @user
        else
            render :edit      
        end
    end
  
    def update
        @user = User.find(params[:id])
        @apply = Apply.new(apply_params)
        #debugger
        if @apply.authorizer == nil
          flash[:danger] = "申請相手を選択してください。"
        elsif @apply.update_attributes!(apply_params)
          Apply.where(user_name: @user.name).where(month: @apply.month).update_all(authorizer_name: "申請中")
          flash[:success] = "ユーザー情報を更新しました。"
        else
          flash[:danger] = "申請に失敗いたしました。"  
        end
        #debugger
        redirect_to @user
    end

    def edit_one_month
        @user = User.find(params[:id])
        @users = User.find(params[:user_id])
        @apply1 = Apply.where(authorizer: params[:user_id]) # 申請した人のapply表示。
        @apply1_group = @apply1.group(:month).group(:user_name)
        #@applies = @apply1_group.where(authorizer_name: "申請中")
        @applies = @apply1_group.where(change: false).or(@apply1_group.where(change: nil))
        #@applies_count = @apply1_group.where(authorizer_name: "申請中").sum(:month).count
        @apply_users = User.all.where(name: @applies.where(authorizer: @users.id).select(:user_name))
       # debugger
    end

    def update_one_month
      #debugger
        @user = User.find(params[:user_id])
        @apply = Apply.new(apply_params)
        update_apply_params.each do |id, item|
        apply = Apply.find(id)
        apply.update_attributes!(item)
        #debugger
          if apply.change == true
            #debugger
            Apply.where(authorizer: @user.id).where(user_name: apply.user_name).where(month: apply.month).update_all(authorizer_name: apply.authorizer_name)
            flash[:success] = "残業申請のお知らせを変更しました。"     
          else 
            #debugger
            flash[:danger] = "変更欄に未チェックの申請があります。" 
          end 
        end
        redirect_to @user
    end

    def edit_one_month_show
     # debugger
      @users = User.all
      @first_day = params[:month].to_date
      @last_day = @first_day.end_of_month
      @user = User.find_by(name: params[:name])
      #debugger
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
      #debugger
      @worked_sum = @attendances.where.not(started_at: nil).or(@attendances.where(confirmation_change_status: "承認")).count
    end

    private

    def apply_params
      params.permit(:month, :authorizer, :authorizer_name, :user_name, :created_at ,:updated_at)
    end

    def update_apply_params
      params.require(:user).permit(applies: [:authorizer_name, :change, :updated_at])[:applies]
    end

end
