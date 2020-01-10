class User < ApplicationRecord
    validates :name, presence: true
    validates :bio, presence: true
    has_secure_password
    has_secure_token

    has_many :posts # 渡す側
end
