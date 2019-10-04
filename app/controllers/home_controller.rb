class HomeController < ApplicationController
  def index
    @merchants = Merchant.all

    render json: @merchants
  end
end
