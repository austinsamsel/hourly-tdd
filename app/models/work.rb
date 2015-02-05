class Work < ActiveRecord::Base

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_datetime :start_time
  validates_datetime :end_time, after: :start_time

  def hours_elapsed
    a = Time.diff(start_time, end_time)
    a[:hour]
  end

  private

end
