class Review < ActiveRecord::Base
	validates :name, presence:true
	validates :comment, length: {minimum:5}
	#validates :stars, numericality: {greater_than_or_equal_to:0,less_than_or_equal_to:5}

	STARS = [1, 2, 3, 4, 5]

	validates :stars, inclusion: { 
	  in: STARS,
	  message: "must be between 1 and 5"
	}

 	belongs_to :movie
end
