class AnalyticsController < ApplicationController
  wrap_parameters format: [:json]

  def index
    @document = event_params.to_hash
    @service = Mongo::AnalyticsService.new
    @service.save_event(@document)
    render json: {status: 'ok'}
  end

  private

  def event_params
    params.require(:event).permit(:site, :page, :user_id, :visitor_id, :date)
  end
end
