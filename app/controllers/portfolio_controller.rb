class PortfolioController < ApplicationController
  def index
    @portfolio_items = PortfolioItem.order('published_on DESC').all
  end

  # def show
  # end

end
