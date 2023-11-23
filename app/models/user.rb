class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password

    has_many :posts
end
