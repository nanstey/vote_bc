class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def election
    @elections = Election.all
  end
  helper_method :election

end

