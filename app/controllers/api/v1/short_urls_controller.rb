class Api::V1::ShortUrlsController < Api::V1::ApplicationController
  def create
    @short_url = @api_application.short_urls.new short_url_params
    if @short_url.save
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
end
