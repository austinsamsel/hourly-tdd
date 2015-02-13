require 'rails_helper'

RSpec.describe Work, :type => :model do

  it { should belong_to(:client) }

  it "is valid with a title" do
    expect(build(:work)).to be_valid
  end
  it "is valid without an end time" do
    work = build(:work, end_time: nil)
    work.valid?
    expect(build(:work)).to be_valid
  end
  it "is invalid without a title" do
    work = build(:work, title: ' ')
    work.valid?
    expect(work.errors[:title]).to include("can't be blank")
  end
  it "is invalid without a real start time" do
    work = build(:work, start_time: ' ')
    work.valid?
    expect(work.errors[:start_time]).to include("is not a valid datetime")
  end
  it "is invalid without a real end time" do
    work = build(:work, end_time: ' ')
    work.valid?
    expect(work.errors[:end_time]).to include("is not a valid datetime")
  end
  it "is invalid if end time is earlier than start time" do
    work = build(:work, 
      start_time: "2008-08-20 17:56:21",
      end_time: "2008-08-20 16:56:21"
    )
    work.valid?
    expect(work.errors[:end_time]).to include("must be after the start time")
  end
  it "is valid if end time is later than start time" do
    expect(build(:work)).to be_valid
  end
  it "is valid without a description" do
    work = build(:work, description: ' ')
    work.valid?
    expect(work).to be_valid
  end
  it "is valid billed" do
    work = build(:work, billed: true)
    work.valid?
    expect(work).to be_valid
  end
  it "is valid unbilled" do
  work = build(:work, billed: false)
    expect(work).to be_valid
  end
  it "is valid with hours elapsed" do
    expect(build(:work).hours_elapsed).to eq 1
  end
  it "has the recent posts listed first"
end