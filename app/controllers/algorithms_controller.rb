class AlgorithmsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_algorithm, only: [:show, :edit, :update, :destroy, :check_syntax]
  layout 'full_width', only: [:edit, :update]

  # GET /algorithms
  def index
    @algorithms = current_user.algorithms.all
  end

  # GET /algorithms/1
  def show
  end

  # GET /algorithms/new
  def new
    @algorithm = current_user.algorithms.new
  end

  # GET /algorithms/1/edit
  def edit
  end

  # POST /algorithms
  def create
    @algorithm = current_user.algorithms.new(algorithm_params)

    if @algorithm.save
      redirect_to edit_algorithm_path(@algorithm), notice: 'Algorithm was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /algorithms/1
  # PATCH/PUT /algorithms/1.json
  def update
    respond_to do |format|
      if @algorithm.update(algorithm_params)
        format.html { redirect_to @algorithm, notice: 'Algorithm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @algorithm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /algorithms/1
  # DELETE /algorithms/1.json
  def destroy
    @algorithm.destroy
    respond_to do |format|
      format.html { redirect_to algorithms_url }
      format.json { head :no_content }
    end
  end

  # GET /algorithms/1/check_syntax
  def check_syntax

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_algorithm
      @algorithm = Algorithm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def algorithm_params
      params.require(:algorithm).permit(:user_id, :name, :code, :privacy)
    end
end
