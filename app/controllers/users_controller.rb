class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @algorithms = @user.algorithms.accessible_by(current_ability)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end