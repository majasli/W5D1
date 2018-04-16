class GoalsController < ApplicationController


  def new
    @goal = Goal.new
  end

  def index
  end

  def show
  end

  def create
    @goal = current_user.goals.new(goal_params)
    #@goal = Goal.new(goal_params)
    #@goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
  end

  def destroy

  end

  def edit
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :finished, :visibility)
  end

end
