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

  context "ordering" do
    before(:each) do
      @t1 = Factory(:task, :ordering => 0)
      @t2 = Factory(:task, :ordering => 1)
      @t3 = Factory(:task, :ordering => 2)
      @t4 = Factory(:task, :ordering => 3)
      @t5 = Factory(:task, :ordering => 4)
    end

    it "should move other elements down when moving up" do
      @t2.ordering = 3
      @t2.save
      @t1.reload.ordering.should == 0
      @t3.reload.ordering.should == 1
      @t4.reload.ordering.should == 2
      @t5.reload.ordering.should == 4
    end

    it "should move other elements up when moving down" do
      @t4.ordering = 1
      @t4.save
      @t1.reload.ordering.should == 0
      @t2.reload.ordering.should == 2
      @t3.reload.ordering.should == 3
      @t5.reload.ordering.should == 4
    end

    it "should get a default order based on the other tasks" do
      t = Factory(:task)
      t.ordering.should == 5
    end
  end
end
