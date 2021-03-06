class Api::V1::ShortUrlsController < Api::V1::ApplicationController
  before_action :find_short_url, except: [:create]

  def create
    @short_url = @api_application.short_urls.new short_url_params

    rescue_not_unique_exception do
      if @short_url.save
        render :show, status: 201
      else
        render_json_error(@short_url)
      end
    end
  end

  def update
    rescue_not_unique_exception do
      if @short_url.update short_url_params
        render :show
      else
        render_json_error(@short_url)
      end
    end
  end

  def destroy
    @short_url.destroy
    head 204
  end

  def show
  end

  private

  def short_url_params
    params.permit(
      :destination,
      :length, :custom_key, char_set: []
    )
  end

  def find_short_url
    @short_url = @api_application.short_urls.find_by! key: params[:id]
  end

  def rescue_not_unique_exception
    begin
      yield
    rescue ActiveRecord::RecordNotUnique
      render json: { errors: ['并发造成的短链接重复，请重试'] }, status: 422
    end
  end
end
