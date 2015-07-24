class KeywordMstsController < ApplicationController
  before_action :set_keyword_mst, only: [:show, :edit, :update, :destroy]

  # GET /keyword_msts
  # GET /keyword_msts.json
  def index
    @keyword_msts = KeywordMst.all
  end

  # GET /keyword_msts/1
  # GET /keyword_msts/1.json
  def show
  end

  # GET /keyword_msts/new
  def new
    @keyword_mst = KeywordMst.new
  end

  # GET /keyword_msts/1/edit
  def edit
  end

  # POST /keyword_msts
  # POST /keyword_msts.json
  def create
    @keyword_mst = KeywordMst.new(keyword_mst_params)

    respond_to do |format|
      if @keyword_mst.save
        format.html { redirect_to @keyword_mst, notice: 'Keyword mst was successfully created.' }
        format.json { render :show, status: :created, location: @keyword_mst }
      else
        format.html { render :new }
        format.json { render json: @keyword_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keyword_msts/1
  # PATCH/PUT /keyword_msts/1.json
  def update
    respond_to do |format|
      if @keyword_mst.update(keyword_mst_params)
        format.html { redirect_to @keyword_mst, notice: 'Keyword mst was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_mst }
      else
        format.html { render :edit }
        format.json { render json: @keyword_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_msts/1
  # DELETE /keyword_msts/1.json
  def destroy
    @keyword_mst.destroy
    respond_to do |format|
      format.html { redirect_to keyword_msts_url, notice: 'Keyword mst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_mst
      @keyword_mst = KeywordMst.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_mst_params
      params.require(:keyword_mst).permit(:keyword)
    end
end
