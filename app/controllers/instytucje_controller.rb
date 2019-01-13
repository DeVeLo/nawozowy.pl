class InstytucjeController < ApplicationController
  before_action :set_instytucja, only: [:show]
  
  def show
    render json: @instytucja
  end

  private
  def set_instytucja
    @instytucja = Instytucja.find(params['id'])
  end
  
end
