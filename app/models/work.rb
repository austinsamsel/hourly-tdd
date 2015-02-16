class Work < ActiveRecord::Base

  belongs_to :client
  belongs_to :user
  validates :title, presence: true
  validates_datetime :start_time
  validates_datetime :end_time
  validates_datetime :end_time, after: :start_time
  default_scope -> { order(created_at: :desc) }


  def time_elapsed
    elapsed = (start_time - end_time).to_i.abs
    hours = elapsed / 3600.0
    return hours.round(2)
  end

  def money_dollars
    if billed == true
      return "$$$$$"
    else
      return "nope."
    end
  end

  def faded
    if billed == true
      return "faded"
    end
  end

  def total_billed
    Work.where(billed: true).time_elapsed.sum
  end

  def time_unbilled
  end

end
