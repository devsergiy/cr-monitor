require 'token_digest'

module ::Agent
  class Token
    include Dynamoid::Document

    field :token, :string, default: -> { TokenDigest.generate }
    field :updated_at, :datetime, default: -> { Time.zone.now }

    belongs_to :instance, class: ::Agent::Instance, inverse_of: :token

    def refresh_token!
      self.token = TokenDigest.generate
      save
    end
  end
end
