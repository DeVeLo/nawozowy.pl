class BobowateController < ApplicationController
  def index
    render json: Bobowata.all.order(id: :ASC)
  end
end
