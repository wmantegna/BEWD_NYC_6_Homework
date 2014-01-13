class BeersController < ApplicationController
  def index
  	@beers = Beer.all
  end

  def new
  	@beer = Beer.new
    @beer_styles = BeerStyle.all
  end

  def create
    @beer = Beer.create(beer_params)

    if @beer.save
      redirect_to "/beers/#{@beers.id}"
    else
      flash[:error] = "Something went wrong!"
      redirect_to new_beer_path
    end
  end

  def show
  	@beer = Beer.find(params[:id])
  end

  def edit
  	@beer = Beeer.find(params[:id])
  end

  def update
  	@beer = Beeer.find(params[:id])
  	@beer.update_attributes(beer_params)
  end

  private
  def beer_params
  	params.require(:beer).permit(:name, :beer_style, :og, :fg, :abv, :dateBrewed, :dateBottled, :priming, :recipe, :rating, :brewerComment)
  end
end
