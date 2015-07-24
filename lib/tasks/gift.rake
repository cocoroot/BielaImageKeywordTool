namespace :gift do

	desc "画像－キーワード集計＆内積値設定"

	require 'matrix'

	task :set => :environment do
	
		#イメージ画像ID、キーワードID取得、keyword_storeに設定されている評価結果のSumを取得
		images = ActiveRecord::Base.connection.select_all("select id from image_msts order by id")
		keywords = ActiveRecord::Base.connection.select_all("select id from keyword_msts order by id")
		results = ActiveRecord::Base.connection.select_all("select image_mst_id, keyword_mst_id , count(*) from keyword_stores group by image_mst_id ,keyword_mst_id order by image_mst_id")
		
		# 評価結果格納用の多次元配列（画像ID、キーワードIDは1スタートなので＋１で作成）
		ii = images.length
		ik = keywords.length
		arr = Array.new(ii+1){ Array.new(ik+1, 0) }

		for result in results do
			i = result["image_mst_id"]
			k = result["keyword_mst_id"]
			c = result["count(*)"]
			arr[i][k] = c
		end
		
		#ベクトル作成(image_mstsのvector_sizeへデータセット）
		p "ベクトル作成開始"
		vectors = Array.new(ii+1)
		vi = 1
		while vi <= ii do
			vectors[vi] = Vector.elements(arr[vi],false)
			unless vectors[vi].r == 0
				vectors[vi].normalize
			end
			imagemsts = ImageMst.find(vi)
			imagemsts.update_attribute(:vector_size, vectors[vi].r)
			vi +=1
		end
		
		#内積の作成（similar_imagesにdelete insert）
zz		p "内積作成開始"
		SimilarImage.delete_all
		ni = 1
		while ni <= ii do
			ni2 = 1
			while ni2 <= ii do
				if ni != ni2
					#p vectors[ni].inner_product(vectors[ni2])
					SimilarImage.create(image_id_src:ni,image_id_tgt:ni2,inner_product:vectors[ni].inner_product(vectors[ni2]))
					
				end
				ni2 += 1
			end
			ni += 1
		end

		

	end
end
