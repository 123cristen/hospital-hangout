class HospitalsController < ApplicationController
  def new
  	@hospital = Hospital.new
  end

  def show
  	@hospital = Hospital.find(params[:id])
  end
end
