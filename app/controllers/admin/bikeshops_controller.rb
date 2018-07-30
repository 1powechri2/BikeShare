class Admin::BikeshopsController < ApplicationController

  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.create(accessory_params)
    if @accessory.save
      flash[:success] = "You have successfully created new accessory #{@accessory.title}"
      redirect_to admin_bikeshops_path
    else
      flash[:notice] = "Accessory was not properly created"
      render :new
    end
  end

  def edit
    @accessory = Accessory.find(params[:id])
  end

  def update
    @accessory = Accessory.find(params[:id])
    if params[:commit] == "Change Status"
      @accessory.update(status:params[:status])
      redirect_to admin_bikeshops_path
    else
      @accessory.update(accessory_params)
      if @accessory.save
        flash[:success] = "You have successfully updated accessory for #{@accessory.title}"
        redirect_to admin_bikeshops_path
      else
        flash[:notice] = "Accessory was not properly updated"
        render :edit
      end
    end
  end

  private

  def accessory_params
    params.require(:accessory).permit(:title, :description, :price, :image, :status)
  end

end
