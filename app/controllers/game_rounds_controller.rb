class GameRoundsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_round, only: [:show, :edit, :update, :destroy, :results]

  # GET /game_rounds
  # GET /game_rounds.json
  def index
    authorize! :manage, GameRound
    @game_rounds = GameRound.all
  end

  # GET /game_rounds/1
  # GET /game_rounds/1.json
  def show
  end

  # GET /game_rounds/new
  def new
    authorize! :create, GameRound
    @game_round = GameRound.new
  end

  # GET /game_rounds/1/edit
  def edit
    authorize! :update, @game_round
  end

  # POST /game_rounds
  # POST /game_rounds.json
  def create
    authorize! :create, GameRound
    @game_round = GameRound.new(game_round_params)

    respond_to do |format|
      if @game_round.save
        format.html { redirect_to @game_round, notice: 'Game round was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game_round }
      else
        format.html { render action: 'new' }
        format.json { render json: @game_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_rounds/1
  # PATCH/PUT /game_rounds/1.json
  def update
    authorize! :update, @game_round
    respond_to do |format|
      if @game_round.update(game_round_params)
        format.html { redirect_to @game_round, notice: 'Game round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game_round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_rounds/1
  # DELETE /game_rounds/1.json
  def destroy
    authorize! :destroy, @game_round
    @game_round.destroy
    respond_to do |format|
      format.html { redirect_to game_rounds_url }
      format.json { head :no_content }
    end
  end

  # GET /game_rounds/1/results
  def results
    render json: @game_round.results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_round
      @game_round = GameRound.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_round_params
      params.require(:game_round).permit(:name, :started_at, :ended_at)
    end
end
