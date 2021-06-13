class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }

  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :before_finished_at_is_invalid_without_a_started_at
  # 退勤時間が存在しない場合、退勤時間は無効
  # 出勤・退勤時間どちらも存在する時、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  validate :before_started_at_than_finished_at_fast_if_invalid
  # 出勤のみは無効
  validate :before_started_at_is_invalid_without_a_finished_at

  validate :note_blank_filure

  validate :confirmation_id_blank_filure

  validate :note_blank_filure_without

  validate :before_started_at_than_finished_at_fast_if_invalid2

  validate :before_started_at_than_finished_at_fast_if_invalid3

  validate :before_started_at_than_finished_at_fast_if_invalid4

  validate :before_started_at_than_finished_at_fast_if_invalid5

  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end

  def before_finished_at_is_invalid_without_a_started_at
    errors.add(:before_started_at, "が必要です") if before_started_at.blank? && before_finished_at.present?
  end

  def before_started_at_is_invalid_without_a_finished_at
    errors.add(:before_finished_at, "が必要です") if before_started_at.present? && before_finished_at.blank?
  end

  def note_blank_filure
    errors.add(:note, "が必要です") if before_started_at.present? && before_finished_at.present? && note.blank?
  end

  def confirmation_id_blank_filure
    errors.add(:confirmation_id, "が必要です") if before_started_at.present? && before_finished_at.present? && note.present? && confirmation_id.blank?
  end

  def note_blank_filure_without
    errors.add(:before_started_at, "が必要です") if before_started_at.blank? && before_finished_at.blank? && note.present? 
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if before_started_at.present? && before_finished_at.present? && next_day2 == false
      errors.add(:before_started_at, "より早い退勤時間は無効です") if before_started_at > before_finished_at
    end
  end

  def before_started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present? 
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end

  def before_started_at_than_finished_at_fast_if_invalid2
    if before_finished_at.present? && next_day2 == true
      errors.add(:started_at, "より早い退勤時間は無効です") if Time.current.change(hour: 8).change(min: 30) < before_finished_at
      #debugger
    end
  end

  def before_started_at_than_finished_at_fast_if_invalid3
    if scheduled_end_time.present? && next_day == true
      errors.add(:started_at, "より早い退勤時間は無効です") if Time.current.change(hour: 8).change(min: 30).to_time < scheduled_end_time.to_time
      #debugger
    end
  end

  def before_started_at_than_finished_at_fast_if_invalid4
    if scheduled_end_time.present? && next_day == false
     errors.add(:started_at, "より早い退勤時間は無効です") if Time.current.change(hour: 17).change(min: 30) > scheduled_end_time
     #debugger
    end
  end

  def before_started_at_than_finished_at_fast_if_invalid5
    if before_started_at.present? && next_day2 == true
     errors.add(:started_at, "より早い退勤時間は無効です") if before_started_at.to_time < Time.current.change(hour: 8).change(min: 30).to_time
     #debugger
    end
  end
end