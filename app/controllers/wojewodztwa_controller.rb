class WojewodztwaController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Wojewodztwo.all.order(name: :ASC) }
    end
  end
end
