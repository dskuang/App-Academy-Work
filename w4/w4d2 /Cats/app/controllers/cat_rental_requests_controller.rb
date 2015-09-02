class CatRentalRequestsController < ApplicationController

  def new
    @allcats = Cat.all
    @catrentalrequest = CatRentalRequest.new
  end

  def create
    @catrentalrequest = CatRentalRequest.new(cat_rental_request_params)

    if @catrentalrequest.save
      redirect_to cat_url( @catrentalrequest.cat_id )
    else

      render :new
    end
  end

  def approve
    @catrentalrequest = CatRentalRequest.find(params[:id])
    if @catrentalrequest.approve!
      redirect_to cat_url( @catrentalrequest.cat_id )
    else
      render json: @catrentalrequest.errors.full_messages, status: :unprocessable_entity
    end
  end

  def deny
    @catrentalrequest = CatRentalRequest.find(params[:id])
    @catrentalrequest.denied!
    redirect_to cat_url( @catrentalrequest.cat_id )
  end

  private

  def cat_rental_request_params
    params[:cat_rental_requests].permit(:cat_id, :start_date, :end_date)
  end
end
