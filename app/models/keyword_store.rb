class KeywordStore < ActiveRecord::Base
	belongs_to :keyword_mst
	belongs_to :image_mst
end
