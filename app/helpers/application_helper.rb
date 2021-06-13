module ApplicationHelper

  def full_title(page_name = "")
    base_title = "KintaiA"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end

  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  def css_class(wo)
    case $days_of_the_week[wo.wday]
    when '土'
      'text-primary'
    when '日'
      'text-danger'
    end
  end
end