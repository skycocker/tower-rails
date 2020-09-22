class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def refresh_headers
    ActiveRecord::Base.connected_to(role: :writing) do
      # Lock the user record during any auth_header updates to ensure
      # we don't have write contention from multiple threads
      @resource.with_lock do
        # should not append auth header if @resource related token was
        # cleared by sign out in the meantime
        return if @used_auth_by_token && @resource.tokens[@token.client].nil?

        # update the response header
        response.headers.merge!(auth_header_from_batch_request)
      end # end lock
    end
  end
end
