require 'rails_helper'

RSpec.describe Work, :type => :model do
  before :each do
    @work = Work.new(
      start_time: "2008-08-20 16:56:21",
      end_time: "2008-08-20 17:56:21",
      title: "a job",
      description: "some work i did",
      billed: false
    )
    @fail = Work.new(
      start_time: nil,
      end_time: nil,
      title: nil,
      description: nil,
      billed: nil
    )
  end
  it "is valid with a title" do
    expect(@work).to be_valid
  end
  it "is invalid without a title" do
    work = Work.new(
      title: nil
    )
    work.valid?
    expect(work.errors[:title]).to include("can't be blank")
  end
  it "is invalid without a real start time" do
    work = Work.new(
      start_time: " "
    )
    work.valid?
    expect(work.errors[:start_time]).to include("is not a valid datetime")
  end
  it "is invalid without a real end time" do
    work = Work.new(
      end_time: " "
    )
    work.valid?
    expect(work.errors[:end_time]).to include("is not a valid datetime")
  end
  it "is invalid if end time is earlier than start time" do
    work = Work.new(
      start_time: "2008-08-20 17:56:21",
      end_time: "2008-08-20 16:56:21"
    )
    work.valid?
    expect(work.errors[:end_time]).to include("must be after the start time")
  end
  it "is valid if end time is later than start time" do
    expect(@work).to be_valid
  end
  it "is valid without a description" do
    work = Work.new(
      start_time: "2008-08-20 16:56:21",
      end_time: "2008-08-20 17:56:21",
      title: "a job",
      description: nil,
      billed: false
    )
    work.valid?
    expect(work).to be_valid
  end
  it "is valid billed" do
    work = Work.new(
      start_time: "2008-08-20 16:56:21",
      end_time: "2008-08-20 17:56:21",
      title: "a job",
      description: nil,
      billed: true
    )
    work.valid?
    expect(work).to be_valid
  end
  it "is valid unbilled" do
  work = Work.new(
      start_time: "2008-08-20 16:56:21",
      end_time: "2008-08-20 17:56:21",
      title: "a job",
      description: nil,
      billed: false
    )
  end
end