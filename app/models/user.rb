class User < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    has_secure_password
    has_secure_token
end
