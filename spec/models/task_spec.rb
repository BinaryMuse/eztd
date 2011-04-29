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

  context "grouping" do
    before(:each) do
      5.times { Factory(:task, :completed => true) }
      5.times { Factory(:task, :completed => false) }
    end

    it "should return the correct tasks in the 'completed' scope" do
      Task.completed.count.should == 5
    end

    it "should return the correct tasks in the 'uncompleted' scope" do
      Task.uncompleted.count.should == 5
    end
  end
end
