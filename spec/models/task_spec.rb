require 'spec_helper'

describe Task do
  it { should respond_to :text, :completed }

  it "should default to not completed" do
    task = Factory(:task)
    task.completed.should == false
  end

  it "should require a non-blank text" do
    task = Factory.build(:task)
    task.text = ""
    task.should have(1).error_on(:text)
  end
end
