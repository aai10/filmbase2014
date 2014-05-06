class GenresController < ApplicationController
  before_action :check_auth
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  before_action :check_edit, only: [:edit, :update, :destroy]
  before_action :check_add, only: [:new, :create]


  def index
    @genres = Genre.ordering.page(params[:page])
  end

  def show
  end


  def new
    @genre = Genre.new
  end


  def edit
  end


  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: 'Жанр создан.'
    else
      render :new
    end
  end


  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: 'Жанр сохранен.'
    else
      render :edit
    end
  end


  def destroy
    if @genre.destroy
      redirect_to genres_url, notice: 'Жанр удален.'
    else
      redirect_to @genre, danger: "Невозможно удалить жанр."
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end


  def genre_params
    params.require(:genre).permit(:name)
  end

  def check_edit
    unless @country.edit?(@current_user)
      redirect_to @country, danger: "Доступ запрещен"
    end
  end

  def check_add
    unless Country.add?(@current_user)
      redirect_to countries_path, danger: "Доступ запрещен"
    end
  end
end
