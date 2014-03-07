class MoviesController < ApplicationController
  before_action :require_user, except: [:index,:show]
  before_action :user_admin, except: [:index,:show]
  before_action :authorize_user, only: [:new,:create,:edit,:update,:destroy]

  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end
  
  def edit
    @movie = Movie.find(params[:id])
  end
  
  def update
    @movie = Movie.find(params[:id])
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
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, notice: "Movie Deleted Successfully!!!"
  end
  
private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name)
  end
end

