class ReviewsController < ApplicationController
  before_action :require_user, except: [:index,:show]
  #before_action :authorize_user, only: [:new,:create,:edit,:update,:destroy]
	before_action :set_movie

	def index
		@reviews = @movie_rev.reviews
	end

	def new
		@review = @movie_rev.reviews.new
	end

	def create
		@review = @movie_rev.reviews.new(review_params)
    @review.user = current_user
		if @review.save
			redirect_to movie_reviews_path(@movie_rev), notice:"Thanks for your review!!!"
		else
			render :new
		end
	end


	private
		def review_params
			params.require(:review).permit(:comment,:stars)
		end

		def set_movie
			@movie_rev = Movie.find_by(slug: params[:movie_id])
		end
end
