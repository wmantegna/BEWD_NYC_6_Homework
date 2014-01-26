class BeerStylesController < ApplicationController
  
  before_action :set_beer_style, only: [:show, :edit, :update, :destroy]

  def index
  	@beerStyles = BeerStyle.all.order("lower(name) asc")
  end

  def show
    @beers = @beerStyle.beers.order(rating: :desc)
  end

  def new
  	@beerStyle = BeerStyle.new
  end

  def create
  	@beerStyle = BeerStyle.create(beer_style_params)
  	
  	if @beerStyle.save
  		redirect_to "/beer_styles/#{@beerStyle.id}"
  	else
  		flash[:error] = "Something went wrong!"
  		redirect_to new_beer_style_path
  	end
  end

  def edit
  end

  def update
  	@beerStyle.update_attributes(beer_style_params)
  	redirect_to "/beer_styles/#{@beerStyle.id}"
  end

  def destroy
  	@beerStyle.destroy
  	redirect_to beer_styles_path
  end

  private
  def beer_style_params
  	params.require(:beer_style).permit(:name, :category, :description, :abvMin, :abvMax, :ibuMin, :ibuMax, :ogMin, :ogMax, :fgMin, :fgMax, :srmMin, :srmMax)
  end

  def set_beer_style
    @beerStyle = BeerStyle.find(params[:id])
  end
end