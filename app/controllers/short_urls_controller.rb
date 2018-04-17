class ShortUrlsController < ApplicationController
  before_action :find_short_url, only: [:show, :edit, :update]

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new short_url_params
    if @short_url.save
      flash[:success] = '创建成功'
      redirect_to @short_url
    else
      flash.now[:danger] = @short_url.errors.full_messages.join('，')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @short_url.update short_url_params
      flash[:success] = '更新成功'
      redirect_to @short_url
    else
      flash.now[:danger] = @short_url.errors.full_messages.join('，')
      render :edit
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(
      :destination,
      :length, :custom_key, char_set: []
    )
  end

  def find_short_url
    @short_url = ShortUrl.find(params[:id])
  end
end
