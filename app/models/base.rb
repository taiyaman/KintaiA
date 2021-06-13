class Base < ApplicationRecord
    validates :id, uniqueness: true
    validates :name, presence: true
    # validates :attendance, inclusion: { in: %w(出勤　退勤) }
end
