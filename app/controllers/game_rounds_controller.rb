class GameRoundsController < ApplicationController
  before_action :set_game_round, only: [:show, :edit, :update, :destroy]

  # GET /game_rounds
  # GET /game_rounds.json
  def index
    @game_rounds = GameRound.all
  end

  # GET /game_rounds/1
  # GET /game_rounds/1.json
  def show
  end

  # GET /game_rounds/new
  def new
    @game_round = GameRound.new
  end

  # GET /game_rounds/1/edit
  def edit
  end

  # POST /game_rounds
  # POST /game_rounds.json
  def create
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
    @game_round.destroy
    respond_to do |format|
      format.html { redirect_to game_rounds_url }
      format.json { head :no_content }
    end
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
