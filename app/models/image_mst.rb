class ImageMst < ActiveRecord::Base
	has_many :keyword_stores
	has_many :keyword_msts, through: :keyword_stores

	# veector_size‚ª‘å‚«‚¢‚à‚Ì‚ðƒ‰ƒ“ƒ_ƒ€‚É6ŒŽæ“¾
	def self.random_highvector_id
		result = ImageMst.all
    	vector_sum = 0
    	result.each do |d|
        	vector_sum +=  d.vector_size
    	end
    	result.each do |d|
        	d.vector_size /= vector_sum
    	end
    	r = rand()
    	sum = 0
		arr = Array.new
		while arr.length < 6 do
	    	result.each do |d|
	        	sum += d.vector_size
	        	if r < sum 
					unless arr.include?(d.id)
						arr.push(d)
						sum = 0
					end
				end
	    	end
		end
    	return arr
	end
end
