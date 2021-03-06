class MoviesController < ApplicationController
  before_action :require_user, except: [:index,:show]
  before_action :user_admin, except: [:index,:show]
  before_action :set_movie, only: [:show,:update,:edit,:destroy]
 # before_action :authorize_user, only: [:new,:create,:edit,:update,:destroy]

  def index
    case(params[:scope])
      when ("hits")
        @movies = Movie.hits
      when ("flops")
        @movies = Movie.flops
      when ("upcoming")
        @movies = Movie.upcoming
      when ("recent")
        @movies = Movie.recent # default is 5
      else
        @movies = Movie.released
    end
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres

    if(current_user)
      @user_already_favourite = @movie.favourites.find_by(user_id: current_user.id)
    end
  end
  
  def edit
  end
  
  def update
    if @movie.update(movie_params)
      flash[:notice] = "Movie Updated Successfully!!!"
      redirect_to @movie
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice]= "Movie Created Successfully!!!"
      redirect_to @movie
    else
      render :new
    end
  end
  
  def destroy
    @movie.destroy
    redirect_to movies_url, notice: "Movie Deleted Successfully!!!"
  end
  
private

  def set_movie
    @movie = Movie.find_by(slug: params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :rating,
                                  :released_on, :total_gross, :cast, :director,
                                  :duration, :image, :slug, genre_ids: [])
  end
end

