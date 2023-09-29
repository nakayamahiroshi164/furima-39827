class OrdersController < ApplicationController
  def index
   @orders = current_user.orders
  end

  def create
    binding.pry
  end
end
