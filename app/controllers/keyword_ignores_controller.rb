class KeywordIgnoresController < ApplicationController
  before_action :set_keyword_ignore, only: [:show, :edit, :update, :destroy]

  # GET /keyword_ignores
  # GET /keyword_ignores.json
  def index
    @keyword_ignores = KeywordIgnore.all
  end

  # GET /keyword_ignores/1
  # GET /keyword_ignores/1.json
  def show
  end

  # GET /keyword_ignores/new
  def new
    @keyword_ignore = KeywordIgnore.new
  end

  # GET /keyword_ignores/1/edit
  def edit
  end

  # POST /keyword_ignores
  # POST /keyword_ignores.json
  def create
    @keyword_ignore = KeywordIgnore.new(keyword_ignore_params)

    respond_to do |format|
      if @keyword_ignore.save
        format.html { redirect_to @keyword_ignore, notice: 'Keyword ignore was successfully created.' }
        format.json { render :show, status: :created, location: @keyword_ignore }
      else
        format.html { render :new }
        format.json { render json: @keyword_ignore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keyword_ignores/1
  # PATCH/PUT /keyword_ignores/1.json
  def update
    respond_to do |format|
      if @keyword_ignore.update(keyword_ignore_params)
        format.html { redirect_to @keyword_ignore, notice: 'Keyword ignore was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_ignore }
      else
        format.html { render :edit }
        format.json { render json: @keyword_ignore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_ignores/1
  # DELETE /keyword_ignores/1.json
  def destroy
    @keyword_ignore.destroy
    respond_to do |format|
      format.html { redirect_to keyword_ignores_url, notice: 'Keyword ignore was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_ignore
      @keyword_ignore = KeywordIgnore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_ignore_params
      params.require(:keyword_ignore).permit(:image_mst_id, :keyword_mst_id)
    end
end
