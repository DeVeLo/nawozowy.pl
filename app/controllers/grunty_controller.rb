class GruntyController < ApplicationController

  def index
    render json: Grunt.all.order(id: :ASC)
  end
  
end
