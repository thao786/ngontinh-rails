class ChaptersController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show ]

  def show
    @fiction = Fiction.find_by path: params[:fiction_id]
    @chapter = @fiction.chapters.where(chapnum: params[:id]).take
    @chapters = @fiction.chapters.order("chapnum ASC").page(2)
    @random = Fiction.order("RANDOM()").limit(6)
  end

  def new
    @fiction = Fiction.find_by path: params[:fiction_id]
  end

  def create
    @fiction = Fiction.find_by path: params[:fiction_id]
    @chapter = @fiction.chapters.create(chapter_params)
    redirect_to fiction_path(@fiction)
  end

  def edit
  #  render plain: params.inspect
    @fiction = Fiction.find_by path: params[:fiction_id]
    @chapter = @fiction.chapters.find_by chapnum: params[:id]
  end

  def update
    @fiction = Fiction.find_by path: params[:fiction_id]
    @chapter = @fiction.chapters.where(chapnum: params[:id]).take

    if @chapter.update(chapter_params)
      redirect_to fiction_chapter_path(@fiction, @chapter.chapnum)
    else
      render 'edit'
    end
  end

  def destroy
    @chapter = Chapter.find_by(chapnum: params[:id])
    @chapter.destroy

    redirect_to fiction_path(@chapter.fiction)
  end

  def fiction
    @fiction ||= Fiction.find_by path: params[:path]
  end

  private
    def chapter_params
      params.require(:chapter).permit(:chapnum, :body, :title)
    end
end
