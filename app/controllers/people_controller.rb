class PeopleController < ApplicationController
  before_action :check_auth, except: [:show, :index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :check_add, only: [:new, :create]
  before_action :check_edit, only: [:edit, :update, :destroy]


  def index
    respond_to do |format|
      format.html { @people = Person.ordering.page(params[:page]) }
      format.json do
        @people = Person.ordering.where("upper(name) like upper(:q) or upper(origin_name) like upper(:q)", q: "%#{params[:q]}%").all
        render json: @people
      end
    end

  end

  def show
  end


  def new
    @person = Person.new
  end

  def edit
  end


  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: 'Персона создана'
    else
      render :new
    end
  end


  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Персона изменена'
    else
      render :edit
    end
  end


  def destroy
    if @person.destroy
      redirect_to people_url, notice: 'Персона удалена'
    else
      redirect_to @person, danger: 'Удаление персоны невозможно'
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end


  def person_params
    params.require(:person).permit(:name, :origin_name, :male, :birthday, :avatar)
  end

  def check_add
    render_error(people_path) unless Person.add?(@current_user)
  end

  def check_edit
    render_error(@person) unless @person.edit?(@current_user)
  end

end
