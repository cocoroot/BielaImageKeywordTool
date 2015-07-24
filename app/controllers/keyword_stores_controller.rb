class KeywordStoresController < ApplicationController
#http_basic_authenticate_with name: "dnp", password: "dnp"
  before_action :set_keyword_store, only: [:show, :edit, :update, :destroy]
  def gift

	question_num = 5
	image_num = 6

	@qs = Array.new(question_num) # 質問
	idx = 0
	@h1 = Hash.new #キーワードID、重み
	@h2 = Hash.new #
	@images = Array(image_num) #イメージとキーワードの配列
	@q = Hash.new # 質問
	@used_id = Array.new #利用済み画像ID

	#比較対象となるvector_sizeが大きいものをランダムに取得　
	image_src_ids = ImageMst.random_highvector_id

	while idx < question_num do
		@h1.clear
		@h2.clear
		@q.clear
		@used_id.push(image_src_ids[idx]["id"])

		#image_id_srcのキーワードを取得 ★同じ画像が出ている
		sql = "select keyword_mst_id , count(*) from keyword_stores where image_mst_id = " + image_src_ids[idx]["id"].to_s + " group by image_mst_id ,keyword_mst_id order by image_mst_id"
		keywords_src = ActiveRecord::Base.connection.select_all(sql)
		for keyword in keywords_src do
			@h1[keyword["keyword_mst_id"]] = keyword["count(*)"]
		end
		@h2["imageid"] = image_src_ids[idx]["id"]
		@h2["keywords"] = @h1
		@images[0] = Marshal.load(Marshal.dump(@h2))

		#内積値の小さい順で5件取得（一番関連が薄いもの）★利用済み画像は含まない
		sql2 = "select image_id_tgt from similar_images where image_id_src= " + image_src_ids[idx]["id"].to_s + " and image_id_tgt not in ("+ @used_id.join(',') +") order by inner_product limit 5"
		similars = ActiveRecord::Base.connection.select_all(sql2)
		i=1
	 	for sim in similars do
			sql3 = "select keyword_mst_id , count(*) from keyword_stores where image_mst_id = " + sim["image_id_tgt"].to_s + " group by image_mst_id ,keyword_mst_id order by image_mst_id"
			keywords = ActiveRecord::Base.connection.select_all(sql3)
			@h1.clear
			for keyword in keywords do
				@h1[keyword["keyword_mst_id"]] = keyword["count(*)"]

			end
			@h2["imageid"] = sim["image_id_tgt"]
			@h2["keywords"] = Marshal.load(Marshal.dump(@h1))
			@images[i] = Marshal.load(Marshal.dump(@h2))
			i += 1
			@used_id.push(sim["image_id_tgt"])
		end
	 
		@q["id"] = idx + 1
	 	@q["name"] = "質問_" + (idx + 1).to_s
	 	@q["images"] = @images
		@qs[idx] = Marshal.load(Marshal.dump(@q))
		idx += 1
	end

	#全体をくくる
	@result = Hash.new
	@result["questions"] = @qs

 	render json: @result

  end

  # GET /keyword_stores
  # GET /keyword_stores.json
  def index
#    @keyword_stores = KeywordStore.all

	question_num = 5
	image_num = 6

	@qs = Array.new(question_num) # 質問
	idx = 0
	@h1 = Hash.new #キーワードID、重み
	@h2 = Hash.new #
	@images = Array(image_num) #イメージとキーワードの配列
	@q = Hash.new # 質問


	#比較対象となるvector_sizeが大きいものをランダムに取得　★後で変更（ランダム取得、質問に使われたIDは選ばれないようにする）
	image_src_ids = ActiveRecord::Base.connection.select_all("select id from image_msts order by vector_size desc limit 5")

	while idx < question_num do
		@h1.clear
		@h2.clear
		@q.clear
		#image_id_srcのキーワードを取得　★後で変更（質問に使われたIDは選ばれないようにする）
		sql = "select keyword_mst_id , count(*) from keyword_stores where image_mst_id = " + image_src_ids[idx]["id"].to_s + " group by image_mst_id ,keyword_mst_id order by image_mst_id"
		keywords_src = ActiveRecord::Base.connection.select_all(sql)
		for keyword in keywords_src do
			@h1[keyword["keyword_mst_id"]] = keyword["count(*)"]
		end
		@h2["imageid"] = image_src_ids[idx]["id"]
		@h2["keywords"] = @h1
		@images[0] = @h2

		#内積値の大きい順で5件取得
		sql2 = "select image_id_tgt from similar_images where image_id_src= " + image_src_ids[idx]["id"].to_s + " order by inner_product desc limit 5"
		similars = ActiveRecord::Base.connection.select_all(sql2)
		i=1
	 	for sim in similars do
			sql3 = "select keyword_mst_id , count(*) from keyword_stores where image_mst_id = " + sim["image_id_tgt"].to_s + " group by image_mst_id ,keyword_mst_id order by image_mst_id"
			keywords = ActiveRecord::Base.connection.select_all(sql3)

			for keyword in keywords do
				@h1[keyword["keyword_mst_id"]] = keyword["count(*)"]

			end
			@h2["imageid"] = sim["image_id_tgt"]
			@h2["keywords"] = Marshal.load(Marshal.dump(@h1))
			@images[i] = Marshal.load(Marshal.dump(@h2))
			i += 1
		end
	 
		@q["id"] = idx + 1
	 	@q["name"] = "質問_" + (idx + 1).to_s
	 	@q["images"] = @images
		@qs[idx] = Marshal.load(Marshal.dump(@q))
		idx += 1
	end

	#全体をくくる
	@result = Hash.new
	@result["questions"] = @qs

 	render json: @result

  end

  # GET /keyword_stores/1
  # GET /keyword_stores/1.json
  def show
  end

  # GET /keyword_stores/new
  def new
    @keyword_store = KeywordStore.new
	@images = ImageMst.find(ImageMst.pluck(:id).shuffle[0..4])
	@keyword = KeywordMst.where( 'id >= ?', rand(KeywordMst.first.id..KeywordMst.last.id) ).first
  end

  # GET /keyword_stores/1/edit
  def edit
  end

  # POST /keyword_stores
  # POST /keyword_stores.json
  def create
	@keyword = params[:keyword_mst_id]
	@images = params[:image_mst_id]
	@imagesorg = params[:image_mst_org_id]
	if @images.present? 
		@images.each do |imageid|
			@keyword_store = KeywordStore.new(keyword_mst_id:@keyword,image_mst_id:imageid)
	    	@keyword_store.save
		end
	else
		@imagesorg.each do |imageorgid|
			@keyword_ignore = KeywordIgnore.new(keyword_mst_id:@keyword,image_mst_id:imageorgid)
	    	@keyword_ignore.save
		end
	end
    redirect_to :action => "new"
  end

  # PATCH/PUT /keyword_stores/1
  # PATCH/PUT /keyword_stores/1.json
  def update
    respond_to do |format|
      if @keyword_store.update(keyword_store_params)
        format.html { redirect_to @keyword_store, notice: 'Keyword store was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword_store }
      else
        format.html { render :edit }
        format.json { render json: @keyword_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keyword_stores/1
  # DELETE /keyword_stores/1.json
  def destroy
    @keyword_store.destroy
    respond_to do |format|
      format.html { redirect_to keyword_stores_url, notice: 'Keyword store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword_store
      @keyword_store = KeywordStore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_store_params
      params.require(:keyword_store).permit(:image_mst_id, :keyword_mst_id)
    end
end
