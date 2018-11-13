class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  layout 'admin'

  def index
    @users = User.all
  end
end
