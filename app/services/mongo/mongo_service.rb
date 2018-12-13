class Mongo::MongoService

  def visits
    @collection = client['ahoy_visits']
    @collection.find({})
  end

  def events
    @collection = client['ahoy_events']
    @collection.find({})
  end

  # use with caution
  def clear
    client['ahoy_visits'].drop
    client['ahoy_events'].drop
  end

  def client
    return @client if @client.present?
    options = {
        max_pool_size: 20
    }
    if Rails.env.development?
      options['database'] = 'nimblehq_datastore'
      @client = Mongo::Client.new(['127.0.0.1:27017'], options)
    elsif Rails.env.test?
      options['database'] = 'nimblehq_test_datastore'
      @client = Mongo::Client.new(['127.0.0.1:27017'], options)
    else
      @client = Mongo::Client.new(ENV['MONGO_URL'], options)
    end
  end
end