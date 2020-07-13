class Comment < ApplicationRecord
    belongs_to :post

    validates :body, presence: true, length: { minimum: 10, maximum: 2000 }
    
    def self.comments_for_post(post_id)
        # SELECT "comments".* FROM "comments" WHERE (post_id = 20 and parent_id = 0) ORDER BY id
        Comment.where("post_id = ? and parent_id = 0", post_id).order("id")
    end

    def self.replies_for_post(post_id)
        # SELECT "comments".* FROM "comments" WHERE (post_id = 20 and parent_id != 0) ORDER BY parent_id, id
        Comment.where("post_id = ? and parent_id != 0", post_id).order(["parent_id", "id"]).group_by { |comment| comment["parent_id"] }
    end
end
