class HospitalSessionsController < ApplicationController
  def new
  end

  def create
    @hospital = Hospital.find_by(id: params[:session][:hospital_id])
    if @hospital && @hospital.authenticate(params[:session][:password])
      h_log_in @hospital
      redirect_to @hospital
    else
      flash.now[:danger] = 'Invalid hospital/password combination'
      render 'new'
    end
  end

  def destroy
  	h_log_out if h_logged_in?
  	redirect_to root_url
  end
end
