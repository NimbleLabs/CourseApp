namespace :utils do

  task clear_mongo: :environment do
    Mongo::MongoService.new.clear
  end


end