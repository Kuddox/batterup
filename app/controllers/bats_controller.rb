class BatsController < ApplicationController
  def index
  	@bats = Bat.all
  end

  def show
  	@bat = Bat.find(params[:id])
  end

  def new
  	@bat = Bat.new
  end

  def create
  	@bat = Bat.new(bat_params)

  	if @bat.save
  		redirect_to bats_path
  	else
  		render :new
  	end
  end

  private	

  def bat_params
  	params.require(:bat).permit(:name, :description, :price, :sku)
  end
end
