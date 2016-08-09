class BookingsController < ApplicationController
  def create
    booking_obj = params[:klass].classify.constantize.find_by_id(params[:id])
    @booking = booking_obj.bookings.build(booking_params)
    @booking.user_id = current_user.id if current_user.present?
    @booking.save
    respond_to do |format|
      format.js {}
    end
  end

  private

  def booking_params
    params.require(:booking).permit!
  end
end
