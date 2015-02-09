class Work < ActiveRecord::Base

  belongs_to :client
  belongs_to :user
  validates :title, presence: true
  validates_datetime :start_time
  validates_datetime :end_time, after: :start_time
  default_scope -> { order(created_at: :desc) }

  def hours_elapsed
    a = Time.diff(start_time, end_time)
    a[:hour]
  end

  private

end
