class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session


  def elections
    @elections = Election.all
  end
  helper_method :elections

end

