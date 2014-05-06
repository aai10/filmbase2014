class CountriesController < ApplicationController
  before_action :check_auth
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :check_edit, only: [:edit, :update, :destroy]
  before_action :check_add, only: [:new, :create]


  def index
    @countries = Country.ordering.page(params[:page])
  end

  def show
    @films=@country.films.page(params[:page])
  end

  def new
    @country = Country.new
  end

  def edit
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to @country, notice: 'Страна создана'
    else
      render :new
    end
  end


  def update

    if @country.update(country_params)
      redirect_to @country, notice: 'Страна сохранена'
    else
      render :edit
    end
  end


  def destroy
    if @country.destroy
      redirect_to countries_url, notice: 'Страна удалена'
    else
      redirect_to @country, notice: 'Удаление страны невозможно'
    end
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end


  def country_params
    params.require(:country).permit(:name)
  end

  def check_edit
    render_error(@country) unless @country.edit?(@current_user)
  end

  def check_add
    render_error(countries_path) unless Country.add?(@current_user)
  end
end