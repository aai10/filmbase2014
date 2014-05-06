class FilmsController < ApplicationController
  before_action :set_film, only: [:edit, :update, :destroy]

  before_action :check_auth,except: [:index,:show]
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

  # GET /films/1/edit
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

  # PATCH/PUT /films/1
  # PATCH/PUT /films/1.json
  def update
    respond_to do |format|
      if @film.update(film_params)
        format.html { redirect_to @film, notice: 'Film was successfully updated.' }
        format.json { render :show, status: :ok, location: @film }
      else
        format.html { render :edit }
        format.json { render json: @film.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /films/1
  # DELETE /films/1.json
  def destroy
    @film.destroy
    respond_to do |format|
      format.html { redirect_to films_url, notice: 'Film was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_film
    @film = Film.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def film_params
    params.require(:film).permit(:name, :origin_name, :slogan, :country_id, :genre_id, :director_id, :length, :year,
                                 :trailer_url, :cover, :description, :person_tokens)
  end

  def check_edit
    unless @film.edit?(@current_user)
      redirect_to @film, danger: "Доступ запрещен"
    end
  end

  def check_add
    unless Film.add?(@current_user)
      redirect_to films_path, danger: "Доступ запрещен"
    end
  end
end
