class OptionsController < ApplicationController
  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(option_params)

    if @option.save
      redirect_to @option
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])

    if @option.update(option_params)
      redirect_to @option
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @option = Option.find(params[:id])
    OrderOption.where(:option_id => @option.id ).each do |order|
      order.destroy
    end
    @option.destroy

    redirect_to root_path
  end

  private
  def option_params
    params.require(:option).permit(:name)
  end
end
