class AdminController < ApplicationController
  skip_before_action :track_ahoy_visit
  before_action :authenticate_user!
  before_action :ensure_admin

  layout 'admin'

  def index
    @users = User.all
    service = Mongo::MongoService.new
    @visits = service.visits
    @events = service.events
  end
end
