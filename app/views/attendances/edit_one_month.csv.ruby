require 'csv'

CSV.generate do |csv|
  column_names = %w(日付 出社時間 退社時間)
  csv << column_names
  @attendances.each do |a|
    column_values = [
      a.worked_on,
      if a.before_started_at.present? && a.change_attendance == true && a.confirmation_change_status == "承認"
        a.before_started_at.strftime("%H:%M")
      elsif a.started_at.present? && a.change_attendance == nil
        a.started_at.strftime("%H:%M")
      else
        nil
      end,
      if a.before_finished_at.present? && a.change_attendance == true && a.confirmation_change_status == "承認"
        a.before_finished_at.strftime("%H:%M")
      elsif a.finished_at.present? && a.change_attendance == nil
        a.finished_at.strftime("%H:%M")
      else
        nil
      end
    #a.before_started_at.present? && a.change_attendance == true && a.confirmation_change_status == "承認" ? a.before_started_at.strftime("%H:%M") : nil, 
    #a.before_finished_at.present? && a.change_attendance == true && a.confirmation_change_status == "承認" ? a.before_finished_at.strftime("%H:%M") : nil
    ]
    csv << column_values
  end
end