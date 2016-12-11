class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :glucose_meters

  def todays_report
    self.glucose_meters.today
  end

  def last_month_report
    self.glucose_meters.last_month
  end

  def custom_report(start_date, end_date)
    start_date = DateTime.parse(start_date) if start_date.is_a? String
    end_date = DateTie.parse(end_date) if end_date.is_a? String

    self.glucose_meters.custom_date(start_date, end_date)
  end

end
