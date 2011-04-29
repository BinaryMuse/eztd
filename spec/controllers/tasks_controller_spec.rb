require 'spec_helper'

describe TasksController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should render the index view" do
      get 'index'
      response.should render_template 'index'
    end

    context "with no tasks" do
      it "should display a message about there being no tasks" do
        get 'index'
        response.body.should =~ /don't have anything to do/
      end
    end

    context "with tasks" do
      it "should show the tasks" do
        task = Factory(:task)
        get 'index'
        response.body.should =~ /#{task.text}/
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @attr = Factory.attributes_for(:task)
    end

    it "should redirect back to the root" do
      post 'create', :task => @attr
      response.should redirect_to root_path
    end

    it "should create a task" do
      lambda do
        post 'create', :task => @attr
      end.should change(Task, :count).by(1)
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @task = Factory(:task)
      @attr = Factory.attributes_for(:task)
    end

    it "should redirect back to the root" do
      put 'update', :id => @task, :task => @attr
      response.should redirect_to root_path
    end

    it "should be successful" do
      put 'update', :id => @task, :task => @attr
      flash[:notice].should be_blank
    end

    it "should update the task" do
      lambda do
        @attr[:completed] = true
        put 'update', :id => @task, :task => @attr
        @task.reload
      end.should change(@task, :completed)
    end

  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @task = Factory(:task)
      @attr = { :id => @task.id }
    end

    it "should redirect back to the root" do
      delete 'destroy', :id => @task
      response.should redirect_to root_path
    end

    it "should delete the task" do
      lambda do
        delete 'destroy', :id => @task
      end.should change(Task, :count).by(-1)
    end
  end

end
