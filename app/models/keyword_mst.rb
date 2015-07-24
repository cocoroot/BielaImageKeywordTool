class KeywordMst < ActiveRecord::Base
    has_many :keyword_stores
	has_many :image_msts, through: :keyword_stores
end
