module HospitalSessionsHelper
	# Logs in the given hospital.
  def h_log_in(hospital)
    session[:hospital_id] = hospital.id
  end

  # Returns the current logged-in hospital (if any).
  def current_hospital
    @current_hospital ||= Hospital.find_by(id: session[:hospital_id])
  end

  # Returns true if the hospital is logged in, false otherwise.
  def h_logged_in?
    !current_hospital.nil?
  end

  # Logs out the current hospital.
  def h_log_out
    session.delete(:hospital_id)
    @current_hospital = nil
  end
end
