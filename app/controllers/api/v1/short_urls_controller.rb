class Api::V1::ShortUrlsController < Api::V1::ApplicationController
  before_action :find_short_url, except: [:create]

  def create
    @short_url = @api_application.short_urls.new short_url_params
    if @short_url.save
      render :show, status: 201
    else
      render_json_error(@short_url)
    end
  end

  def update
    if @short_url.update short_url_params
      render :show
    else
      render_json_error(@short_url)
    end
  end

  private

  def short_url_params
    params.permit(
      :destination,
      :length, :custom_key, char_set: []
    )
  end

  def find_short_url
    @short_url = @api_application.short_urls.find params[:id]
  end
end
