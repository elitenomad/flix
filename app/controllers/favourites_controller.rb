class FavouritesController < ApplicationController
  before_action :require_user
  before_action :set_movie

  def create
    @movie.favourites.create!(user:current_user)
    redirect_to @movie, notice: "Thanks for fav'ing!"

  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.destroy

    redirect_to @movie, notice: "Unfav'ing"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
