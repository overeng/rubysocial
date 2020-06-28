require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @post = create(:post, :about_cats)
    @comments = create_list(:comment, 3, post: @post)
    create_list(:comment, 2, parent_id: @comments[0].id, post: @post)
    create_list(:comment, 3, parent_id: @comments[1].id, post: @post)
  end

  test "fetch first level comments for post" do
    Comment.comments_for_post(@post.id).each do |comment|
      assert_equal @comments[0].body, comment.body
      assert_equal @comments[0].post_id, comment.post_id
    end
  end

  test "fetch replies for post" do  
    replies = Comment.replies_for_post(@post.id)
    byebug
    assert_equal 2, replies.length
    assert replies.key?(@comments[0].id)
    assert replies.key?(@comments[1].id)

    assert 2, replies[@comments[0].id].length
    assert 3, replies[@comments[1].id].length
  end
end
