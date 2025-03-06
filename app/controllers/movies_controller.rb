class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end
  
  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    # Initial, bumps into rails security error requiring strong params!
    # @movie = Movie.new(params[:movie])
  
    # This is now corretly allows our params, but it is preferred to be factored out.
    # @movie = Movie.new(params.require(:movie).permit(:title, :director, :release, :genre))

    @movie = Movie.new(movie_params)

    # Previous state, without validation
    # @movie.save
    # redirect_to @movie

    # New state, with validation in place.
    # Note the if condition is enough for @movie.save to be called.
    if @movie.save
      redirect_to @movie
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :director, :release, :genre)
  end
end
