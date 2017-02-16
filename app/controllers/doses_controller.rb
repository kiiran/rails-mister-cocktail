class DosesController < ApplicationController
  def new
    @dose = Dose.new
    @cocktail = find_cocktail
    # assigning cocktail id to dose
    @dose.cocktail = @cocktail
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = find_cocktail
    # # defining the cocktail for the path
    # @cocktail = @dose.cocktail

    respond_to do |format|
      if @dose.save
        format.html { redirect_to cocktail_path(@cocktail.id), notice: 'dose was successfully created.' }
        format.json { render cocktail_path(@cocktail.id), status: :created, location: @dose }
      else
        format.html { render :new }
        format.json { render json: @dose.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @dose = Dose.find(params[:id])
    id = @dose.cocktail.id
    @dose.destroy
    redirect_to cocktail_path(id: id)
  end

  private

  def dose_params
    params.require(:dose).permit(:cocktail_id, :ingredient_id, :description)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
