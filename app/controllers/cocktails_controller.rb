class CocktailsController < ApplicationController
  before_action :set_cocktail , only: [:show, :edit, :update, :destroy, :upvote]
  skip_before_action :authenticate_user!, only: [ :home, :show , :upvote]
  def index
    @cocktails = Cocktail.all.order('name ASC')
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.vote = 0
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
     @cocktail.update(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail.destroy
      redirect_to cocktails_path(@cocktail)
  end

  def top
    #@cocktails = Cocktail.all
    @cocktails = Cocktail.order('vote DESC').limit(20)
  end

  def upvote
    @cocktail.vote = @cocktail.vote.to_i + 1
    @cocktail.save
    redirect_to cocktails_path(@cocktail)

  end

  private

  def set_cocktail
      @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :instruction, :vote, :photo, :photo_cache)
  end

end
