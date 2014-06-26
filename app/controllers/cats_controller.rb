class CatsController < ApplicationController
  
  def index
    @cats = Cat.all
    render 'index'
  end
  
  def show
    @cat = Cat.find(params[:id])
    render 'show'
  end
  
  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cats_url
    else
      flash.now[:errors] = @cat.errors.full_messages
      render 'new'
    end
  end
  
  def cat_params
    params.require(:cat).permit(:name, :age, :sex, :color, :birth_date)
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render 'edit'
  end
  
  def new
    @cat = Cat.new
    render 'new'
  end
  
  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url
    else
      flash.now[:errors] = @cat.errors.full_messages
      render 'edit'
    end
  end
  
end
