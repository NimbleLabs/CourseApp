class Mongo::AnalyticsService
  @@client = nil

  def save_event(event_object)
    mongo_client = Mongo::AnalyticsService.get_connection
    @collection = mongo_client['site_stats']
    @collection.insert_one(event_object)
  end

  def self.get_connection
    return @@client if @@client.present?
    options = {
        max_pool_size: 20
    }
    if Rails.env.development?
      options['database'] = 'NimbleHQEvents'
      @@client = Mongo::Client.new(['127.0.0.1:27017'], options)
    elsif Rails.env.test?
      options['database'] = 'NimbleHQEventsTest'
      @@client = Mongo::Client.new(['127.0.0.1:27017'], options)
    else
      @@client = Mongo::Client.new(ENV['MONGO_URL'], options)
    end
  end

end
