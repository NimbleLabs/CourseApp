class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = true

# better user agent parsing
Ahoy.user_agent_parser = :device_detector

# class Ahoy::Store < Ahoy::DatabaseStore
#
#     def track_event(data)
#
#       if data[:user_id].present?
#         @user = User.find(data[:user_id])
#         return if @user.present? && @user.admin?
#       end
#
#       if data[:properties].present?
#         data.merge!(data[:properties])
#         data.delete(:properties)
#       end
#
#       mongo_save("ahoy_events", data)
#     end
#
#     private
#
#     def mongo_save(collection_name, data)
#       @collection = mongo_client[collection_name]
#       @collection.insert_one(data)
#     end
#
#     def mongo_client
#       return @client if @client.present?
#       options = {
#           max_pool_size: 20
#       }
#       if Rails.env.development?
#         options['database'] = 'nimblehq_datastore'
#         @client = Mongo::Client.new(['127.0.0.1:27017'], options)
#       elsif Rails.env.test?
#         options['database'] = 'nimblehq_test_datastore'
#         @client = Mongo::Client.new(['127.0.0.1:27017'], options)
#       else
#         @client = Mongo::Client.new(ENV['MONGO_URL'], options)
#       end
#
#     end
#
# end

# class Ahoy::Store < Ahoy::BaseStore
#   def track_visit(data)
#     post("ahoy_visits", data)
#   end
#
#   def track_event(data)
#
#     if data[:user_id].present?
#       @user = User.find(data[:user_id])
#       return if @user.present? && @user.admin?
#     end
#
#     if data[:properties].present?
#       data.merge!(data[:properties])
#       data.delete(:properties)
#     end
#
#     post("ahoy_events", data)
#   end
#
#   def geocode(data)
#     post("ahoy_geocode", data)
#   end
#
#   def authenticate(data)
#     post("ahoy_auth", data)
#   end
#
#   private
#
#   def post(collection_name, data)
#     @collection = client[collection_name]
#     @collection.insert_one(data)
#   end
#
#   def client
#     return @client if @client.present?
#     options = {
#         max_pool_size: 20
#     }
#     if Rails.env.development?
#       options['database'] = 'nimblehq_datastore'
#       @client = Mongo::Client.new(['127.0.0.1:27017'], options)
#     elsif Rails.env.test?
#       options['database'] = 'nimblehq_test_datastore'
#       @client = Mongo::Client.new(['127.0.0.1:27017'], options)
#     else
#       @client = Mongo::Client.new(ENV['MONGO_URL'], options)
#     end
#
#   end
# end
