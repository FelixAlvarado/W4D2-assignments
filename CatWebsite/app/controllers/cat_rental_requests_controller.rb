class CatRentalRequests < ApplicationController
 
 def new
   @rental = CatRentalRequests.new
   render :new
 end

 def create
   @rental = CatRentalRequest.new(rental_params)
   if @rental.create
     redirect_to cat_cat_rental_request_url
   else
     render @rental.errors.full_messages, status: 422
   end
 end

 private
 def rental_params
   params.require(:rental_params).permit(:start_date, :end_date, :cat_id, :status)
 end
end
