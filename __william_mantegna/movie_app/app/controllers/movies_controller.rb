class MoviesController < ApplicationController
	def index
		@movies = Movie.all
	end
	
	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.create(movie_params)
		redirect_to "/movies/#{@movie.id}"
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])

		@movie.update_attributes(movie_params)
		redirect_to movie_path
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to movies_path
	end

	private
	def movie_params
		params.require(:movie).permit(:title, :description, :year_released)
	end
end
