class ShortenedUrlsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :verify_authenticity_token


  def create
    destination_url = normalized_url_parameter

    shorted_url = ShortenedUrl.find_or_initialize_by(url: destination_url )

    if shorted_url.save
      render plain: shortened_url_url(shorted_url)
    else
      render_error_message(shorted_url.errors.full_messages)
    end
  end

  def show
    params_unique_key = params.require(:unique_key)
    shortened_url = ShortenedUrl.find_by!(unique_key: params_unique_key)
    shortened_url.increment_usage_count
    render plain: shortened_url.url
  end

  def stats
    shortened_url = ShortenedUrl.find_by!(unique_key: params.require(:unique_key))
    render plain: shortened_url.use_count.to_s
  end

  private

  def normalized_url_parameter
    URI.parse(params.require(:url)).normalize.to_s
  end
end
