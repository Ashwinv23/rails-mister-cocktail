class DosesController < ApplicationController
  # create an instance for the form
  # when user clicks on add dose in the cocktail show page, we need to store the cocktail_id
  # to be passed to the create method for associating dose with the cocktail

  # def new
  #   @dose = Dose.new
  #   @cocktail = Cocktail.find(params[:cocktail_id])
  # end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail # associate the dose to a cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
