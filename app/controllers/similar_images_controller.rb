class SimilarImagesController < ApplicationController
  before_action :set_similar_image, only: [:show, :edit, :update, :destroy]

  # GET /similar_images
  # GET /similar_images.json
  def index
    @similar_images = SimilarImage.all
  end

  # GET /similar_images/1
  # GET /similar_images/1.json
  def show
  end

  # GET /similar_images/new
  def new
    @similar_image = SimilarImage.new
  end

  # GET /similar_images/1/edit
  def edit
  end

  # POST /similar_images
  # POST /similar_images.json
  def create
    @similar_image = SimilarImage.new(similar_image_params)

    respond_to do |format|
      if @similar_image.save
        format.html { redirect_to @similar_image, notice: 'Similar image was successfully created.' }
        format.json { render :show, status: :created, location: @similar_image }
      else
        format.html { render :new }
        format.json { render json: @similar_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /similar_images/1
  # PATCH/PUT /similar_images/1.json
  def update
    respond_to do |format|
      if @similar_image.update(similar_image_params)
        format.html { redirect_to @similar_image, notice: 'Similar image was successfully updated.' }
        format.json { render :show, status: :ok, location: @similar_image }
      else
        format.html { render :edit }
        format.json { render json: @similar_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /similar_images/1
  # DELETE /similar_images/1.json
  def destroy
    @similar_image.destroy
    respond_to do |format|
      format.html { redirect_to similar_images_url, notice: 'Similar image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_similar_image
      @similar_image = SimilarImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def similar_image_params
      params.require(:similar_image).permit(:image_msts_id, :keyword_msts_id, :inner_product)
    end
end
