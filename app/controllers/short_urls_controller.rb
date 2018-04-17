class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new short_url_params
    if @short_url.save
      # todo
      head 200
    else
      flash.now[:danger] = @short_url.errors.full_messages.join('，')
      render :new
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(
      :destination,
      :length, :custom_key, char_set: []
    )
  end
end
