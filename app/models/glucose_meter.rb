class GlucoseMeter < ActiveRecord::Base
  belongs_to :user

  validates :level, presence: true, numericality: {only_float: true}

  scope :today, -> { where(created_at: [DateTime.now.beginning_of_day .. DateTime.now]) }
  scope :last_month, -> { where(created_at: [DateTime.now - 1.month ..DateTime.now]) }
  scope :custom_date, -> (st_date, ed_date){ where(created_at: [st_date ..ed_date]) }

end
