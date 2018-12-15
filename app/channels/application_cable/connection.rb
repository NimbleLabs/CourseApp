module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user_or_visitor

    def connect
      self.current_user_or_visitor = find_verified_user
      logger.add_tags 'ActionCable', current_user_or_visitor.inspect
    end

    protected

    # this checks whether a user is authenticated with devise or is a visitor
    def find_verified_user
      if verified_user = env['warden'].user
        verified_user
      elsif cookies[:ahoy_visitor].present?
        verified_visit = Ahoy::Visit.where(visitor_token: cookies[:ahoy_visitor])
        puts '--------------------------'
        puts 'ApplicationCable visit: ' + verified_visit.inspect
        puts '--------------------------'
        verified_visit
      else
        reject_unauthorized_connection
      end
    end
  end
end

