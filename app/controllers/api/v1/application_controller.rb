class Api::V1::ApplicationController < ApplicationController
  layout false

  protect_from_forgery with: :null_session

  before_action :validate_private_token

  private

  def render_json_error(obj = nil)
    if obj.present?
      render json: { errors: obj.errors.full_messages }, status: :unprocessable_entity
    else
      render json: { errors: ['参数错误'] }, status: :unprocessable_entity
    end
  end

  def validate_private_token
    private_token = params[:private_token] || request.headers['PRIVATE-TOKEN']
    @api_application = ApiApplication.find_by(private_token: private_token)
    render json: { message: "401 Unauthorized" }, status: 401 unless @api_application
  end
end
