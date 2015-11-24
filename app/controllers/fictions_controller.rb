class FictionsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]

  def index
    @fictions = Fiction.page(params[:page])
    @random = Fiction.order("RANDOM()").limit(6)
  end

  def show
    @fiction = Fiction.find_by path: params[:id]

    @genres = @fiction.genres
    @chapters = @fiction.chapters.order("chapnum ASC").page(params[:page])

    @random = Fiction.order("RANDOM()").limit(6)
  end

  def edit
    @fiction = Fiction.find_by path: params[:id]
  end

  def destroy
    @fiction = Fiction.find_by path: params[:id]
    @fiction.destroy

    redirect_to fictions_path
  end

  def new
    @genres = Genre.all
  end

  def create
    @fiction = Fiction.new(fiction_params)
    if not fiction_params['path']
      fiction_params['path'] = "invalid"
    end

    if @fiction.save
      #redirect_to @fiction
      render plain: @fiction.inspect

      genre = Genre.find(params[:fiction][:genres])
      @fiction.genres<<genre
    else
      render 'edit'
    end
  end

  def update
    @fiction = Fiction.find_by path: params[:id]

    if @fiction.update(fiction_params)
      redirect_to @fiction
    else
      render 'edit'
    end
  end

  private
  def fiction_params
    params.require(:fiction).permit(:title, :alternate, :author,
                                    :state, :source, :editor,
                                    :translator, :language)
  end
end
