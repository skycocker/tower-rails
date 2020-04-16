# frozen_string_literal: true

class AuthChannel < ApplicationCable::Channel
  CHANNEL_NAME_PREFIX = 'auth'.freeze

  def subscribed
    return if params[:token].blank?

    @token_value = params[:token]
    stream_from("#{CHANNEL_NAME_PREFIX}_#{@token_value}")
  end

  def unsubscribed
    DisposableToken.find_by(value: @token_value).try(:destroy!)
  end
end
