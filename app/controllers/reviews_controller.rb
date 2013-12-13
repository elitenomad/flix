class ReviewsController < ApplicationController
	before_action :set_movie

	def index
		@reviews = @movie_rev.reviews
	end

	def new
		@review = @movie_rev.reviews.new
	end

	def create
		@review = @movie_rev.reviews.new(review_params)
		if @review.save
			redirect_to movie_reviews_path(@movie_rev), notice:"Thanks for your review!!!"
		else
			render :new
		end
	end


	private
		def review_params
			params.require(:review).permit(:name,:comment,:stars)
		end

		def set_movie
			@movie_rev = Movie.find(params[:movie_id])
		end
end
