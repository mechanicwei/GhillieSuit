class ShortUrlsController < ApplicationController
  before_action :find_short_url, except: [:new, :create, :travel]

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

  def destroy
    @short_url.destroy

    flash[:success] = '删除成功'
    redirect_to [:new, :short_url]
  end

  def travel
    @short_url = ShortUrl.find_by!(key: params[:key])
    @short_url.increment!(:travel_count)
    redirect_to @short_url.destination
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
