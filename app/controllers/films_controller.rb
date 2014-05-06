class FilmsController < ApplicationController
  before_action :set_film, only: [:edit, :update, :destroy]

  before_action :check_auth, except: [:index, :show]
  before_action :check_edit, only: [:edit, :update, :destroy]
  before_action :check_add, only: [:new, :create]

  def index
    @films = Film.ordering.short.page(params[:page])
  end


  def show
    @film=Film.full.find(params[:id])
  end

  def new
    @film = Film.new
  end


  def edit
  end


  def create
    @film = Film.new(film_params)

    if @film.save
      redirect_to @film, notice: 'Фильм создан.'
    else
      render :new
    end
  end


  def update
    if @film.update(film_params)
      redirect_to @film, notice: 'Фильм изменен'
    else
      render :edit
    end
  end


  def destroy
    if @film.destroy
      redirect_to films_url, notice: 'Фильм удален'
    else
      redirect_to @film, danger: "Удаление фильма невозможно"
    end
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end


  def film_params
    params.require(:film).permit(:name, :origin_name, :slogan, :country_id, :genre_id, :director_id, :length, :year,
                                 :trailer_url, :cover, :description, :person_tokens)
  end

  def check_edit
    render_error(@film) unless @film.edit?(@current_user)
  end

  def check_add
    render_error(films_path) unless Film.add?(@current_user)
  end

end
