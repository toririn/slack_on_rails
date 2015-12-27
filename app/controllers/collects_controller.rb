class CollectsController < ApplicationController
  before_action :set_collect, only: [:show, :edit, :update, :destroy]

  # GET /collects
  # GET /collects.json
  def index
    @collects = Collect.all
  end

  # GET /collects/1
  # GET /collects/1.json
  def show
  end

  def search

  end

  # GET /collects/new
  def new
    @collect = Collect.new
  end

  # GET /collects/1/edit
  def edit
  end

  # POST /collects
  # POST /collects.json
  def create
    @collect = Collect.new(collect_params)

    respond_to do |format|
      if @collect.save
        format.html { redirect_to @collect, notice: 'Collect was successfully created.' }
        format.json { render :show, status: :created, location: @collect }
      else
        format.html { render :new }
        format.json { render json: @collect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collects/1
  # PATCH/PUT /collects/1.json
  def update
    respond_to do |format|
      if @collect.update(collect_params)
        format.html { redirect_to @collect, notice: 'Collect was successfully updated.' }
        format.json { render :show, status: :ok, location: @collect }
      else
        format.html { render :edit }
        format.json { render json: @collect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collects/1
  # DELETE /collects/1.json
  def destroy
    @collect.destroy
    respond_to do |format|
      format.html { redirect_to collects_url, notice: 'Collect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collect
      @collect = Collect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collect_params
      params.require(:collect).permit(:name, :text)
    end
end
