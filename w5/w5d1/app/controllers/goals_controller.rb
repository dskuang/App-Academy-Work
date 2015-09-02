class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def show
    @goal = Goal.find(params[:id])
  
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_goal_url
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = ["bad goal"]
      redirect_to edit_goal_url(@goal)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def destroy
    Goal.find(params[:id]).destroy
  end

  def goal_params
    params.require(:goal).permit(:body, :title)
  end
end
