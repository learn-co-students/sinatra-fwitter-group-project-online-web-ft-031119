require 'sinatra/base'

class Helpers
  def self.current_user(session)
    User.find_by_id(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  # def self.current_url
  #   path = request.path_info
  # end

end
