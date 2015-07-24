class ImageMstsController < ApplicationController
  before_action :set_image_mst, only: [:show, :edit, :update, :destroy]

  # GET /image_msts
  # GET /image_msts.json
  def index
    @image_msts = ImageMst.all
  end

  # GET /image_msts/1
  # GET /image_msts/1.json
  def show
  end

  # GET /image_msts/new
  def new
    @image_mst = ImageMst.new
  end

  # GET /image_msts/1/edit
  def edit
  end

  # POST /image_msts
  # POST /image_msts.json
  def create
    @image_mst = ImageMst.new(image_mst_params)

    respond_to do |format|
      if @image_mst.save
        format.html { redirect_to @image_mst, notice: 'Image mst was successfully created.' }
        format.json { render :show, status: :created, location: @image_mst }
      else
        format.html { render :new }
        format.json { render json: @image_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /image_msts/1
  # PATCH/PUT /image_msts/1.json
  def update
    respond_to do |format|
      if @image_mst.update(image_mst_params)
        format.html { redirect_to @image_mst, notice: 'Image mst was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_mst }
      else
        format.html { render :edit }
        format.json { render json: @image_mst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /image_msts/1
  # DELETE /image_msts/1.json
  def destroy
    @image_mst.destroy
    respond_to do |format|
      format.html { redirect_to image_msts_url, notice: 'Image mst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_mst
      @image_mst = ImageMst.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_mst_params
      params.require(:image_mst).permit(:filename)
    end
end
