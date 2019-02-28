class WspiwykorzystaniaController < ApplicationController
  def index
    render json: Wspwykorzystania.all.order(name: :ASC)
  end
end
