require 'spec_helper'

describe Rivendell::DB::Cut do

  ALL_DAYS = %w{sun mon tue wed thu fri sat}.freeze

  describe ".days" do
    described_class.days.should == ALL_DAYS
  end

  describe "enable_on?" do
    ALL_DAYS.each do |day|
      it "should be true when #{day} is Y" do
        subject.send "#{day}=", 'Y'
        subject.should be_enable_on(day)
      end

      it "should be false when #{day} is N" do
        subject.send "#{day}=", 'N'
        subject.should_not be_enable_on(day)
      end
    end
  end

  describe "#days" do
    ALL_DAYS.each do |day|
      it "should contain #{day} when enabled on this day" do
        subject.enable_on(day)
        subject.days.should include(day)
      end

      it "should not contain #{day} when disabled on this day" do
        subject.enable_on(day, false)
        subject.days.should_not include(day)
      end
    end
  end

  describe "#days=" do
    ALL_DAYS.each do |day|
      it "should enable #{day} when present in given days" do
        subject.days = [ day ]
        subject.should be_enable_on(day)
      end

      it "should not contain #{day} when disabled on this day" do
        subject.days = ALL_DAYS - [day]
        subject.should_not be_enable_on(day)
      end
    end
  end

end
