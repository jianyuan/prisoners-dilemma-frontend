class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_round
  before_action :ensure_game_round_active
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  def index
    authorize! :manage, Submission
    @submissions = @game_round.submissions.all
  end

  # GET /submissions/1
  def show
    authorize! :manage, Submission
  end

  # GET /submissions/new
  def new
    @submission = @game_round.submissions.new
    authorize! :submit, @game_round

    if params[:algorithm_id].present?
      algorithm = current_user.algorithms.find(params[:algorithm_id])
      @submission.set_algorithm(algorithm)
    else
      @algorithms = current_user.algorithms.latest
    end
  end

  # POST /submissions
  def create
    algorithm = current_user.algorithms.find(submission_params[:algorithm_id])

    @submission = @game_round.submissions.new
    @submission.user = current_user
    @submission.set_algorithm(algorithm)

    authorize! :submit, @game_round

    if @submission.save
      redirect_to @game_round, notice: 'Submission was successfully created.'
    else
      render action: 'new'
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    authorize! :destroy, @submission
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to game_round_submissions_url(@game_round) }
      format.json { head :no_content }
    end
  end

  private
    def set_game_round
      @game_round = GameRound.find(params[:game_round_id])
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def ensure_game_round_active
      redirect_to @game_round, alert: 'This round has ended!' unless @game_round.active?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:algorithm_id)
    end
end
