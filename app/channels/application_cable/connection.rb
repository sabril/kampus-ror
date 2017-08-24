module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    private
      def find_verified_user
        User.find_by(id: cookies.encrypted[:user_id]) || AdminUser.find_by(id: cookies.encrypted[:user_id])
      end
  end
end
