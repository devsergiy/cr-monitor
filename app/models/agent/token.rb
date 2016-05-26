require 'token_digest'

module ::Agent
  class Token
    include Dynamoid::Document

    field :token, :string, default: -> { TokenDigest.generate }
    field :updated_at, :datetime, default: -> { Time.zone.now }
    field :client_key

    def expired?
      (updated_at - Time.zone.now) > 10.minutes
    end

    def refresh_token!
      self.token = TokenDigest.generate
      save
    end
  end
end
