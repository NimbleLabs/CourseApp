class AdminController < ApplicationController
  skip_before_action :track_ahoy_visit
  before_action :authenticate_user!
  before_action :ensure_admin

  layout 'admin'

  def index
    @users = User.all
    @visits = Ahoy::Visit.all
    @events = Mongo::MongoService.new.events
  end
end
