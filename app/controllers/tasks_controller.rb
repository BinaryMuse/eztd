class TasksController < ApplicationController
  def index
    @new_task = Task.new
    @tasks = Task.all
  end

  def create
    respond_to do |format|
      if @task = Task.create(params[:task])
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path, :notice => "Your task could not be created." }
        format.js { render "error" }
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path, :notice => "There was an error updating your task." }
        format.js { render "error" }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      if @task.destroyed?
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path, :notice => "There was an error deleting your task." }
        format.js { render "error" }
      end
    end
  end

end
