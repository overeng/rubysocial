class SeedCommentsAndReplies < ActiveRecord::Migration[6.0]
    def change
        @post = Post.create :topic_id => 1, :title => "Пост о моем котике", :body => "Это фоточки моего котика"
        @comment1 = Comment.create :post_id => @post.id, :parent_id => 0, :body => "Очень милый котик"
        @reply1 = Comment.create :post_id => @post.id, :parent_id => @comment1.id, :body => "Спасибо :)"
        @reply2 = Comment.create :post_id => @post.id, :parent_id => @comment1.id, :body => "+1"

        @comment2 = Comment.create :post_id => @post.id, :parent_id => 0, :body => "Как зовут котика?"
        @reply3 = Comment.create :post_id => @post.id, :parent_id => @comment2.id, :body => "Барсик"
    end
  end
  