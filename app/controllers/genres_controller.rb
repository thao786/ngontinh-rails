class GenresController < ApplicationController
  def index
    @genres = Genre.all
    @random = Fiction.order("RANDOM()").limit(6)
  end

  def show
    #render plain: params.to_json

    @genre = Genre.find params[:id]
    @random = Fiction.order("RANDOM()").limit(6)
    @fictions = @genre.fictions.page(params[:page])
  end
end
