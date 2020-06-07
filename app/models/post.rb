class Post < ApplicationRecord
    belongs_to :topic

    validates :title, presence: true, length: { maximum: 300 }
    validates :body, presence: true
end
