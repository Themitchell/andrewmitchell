class PortfolioController < ApplicationController
  def index
    @portfolio_items = PortfolioItem.order('published_on DESC').all
  end

  def show
    @portfolio_item = PortfolioItem.find_by_permalink! params[:id]
  end

end
