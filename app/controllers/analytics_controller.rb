class AnalyticsController < ApplicationController
  def index
    puts '***************************'
    puts params['event']
    puts '***************************'
    render json: {status: 'ok'}
  end
end
