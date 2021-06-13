class Apply < ApplicationRecord
  belongs_to :user　, optional: true

  #validates :authorizer_exist, presence: true

  enum mark: { 未申請: 0,　申請中: 1,　承認: 2,　否認: 3 }

  #def authorizer_exist
  #  errors.add(:authorizer, "が必要です") if authorizer.blank?
  #end
end
