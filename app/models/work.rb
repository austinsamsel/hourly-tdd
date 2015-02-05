class Work < ActiveRecord::Base

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  #validates :end_time, :end_after_start
  # validate :end_is_datetime
  # validate :start_is_datetime
  #validates end_after_start
  validates_datetime :start_time
  validates_datetime :end_time, after: :start_time

  private

  # def end_after_start
  #     errors.add(:end_time, "must be after start time") unless
  #         self.end_date < self.start_date
  # end 

end
