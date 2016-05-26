class User
  include Dynamoid::Document
  include ActiveModel::SecurePassword

  has_secure_password

  field :email
  field :password_digest
end
