require 'test_helper'

class PostTest < ActiveSupport::TestCase
    def setup
      @topic_turtles = create(:topic, :turtles)
      @topic_rabbits = create(:topic, :rabbits)
    
      @post_turtles = create_list(:post, 4, :about_turtles, topic: @topic_turtles)[0]
      @post_rabbits = create_list(:post, 4, :about_rabbits, topic: @topic_rabbits)[0]
    end

    test "pagination index" do
        pagination = Services::Pagination.new(nil)
        posts = pagination.first_page

        assert posts.length == 3
        assert posts[-1].id < posts[0].id
        assert posts[0].title == @post_rabbits.title
        assert posts[-1].title == @post_rabbits.title
        refute pagination.has_newer

        pagination = Services::Pagination.new(pagination.construct_page_token)
        posts = pagination.older
        assert posts[-1].id < posts[0].id
        assert posts[0].title == @post_rabbits.title
        assert posts[-1].title == @post_turtles.title

        assert pagination.has_older
        assert pagination.has_newer

        pagination = Services::Pagination.new(pagination.construct_page_token)
        posts = pagination.newer
        assert posts[-1].id < posts[0].id
        assert posts[0].title == @post_rabbits.title
        assert posts[-1].title == @post_rabbits.title

        assert pagination.has_older
        refute pagination.has_newer
    end

    test "pagination topic" do
        pagination = Services::Pagination.new(nil, @topic_turtles.id)
        posts = pagination.first_page

        assert posts.length == 3
        sorted_posts = posts.sort_by { |post| -post.id }

        assert_equal sorted_posts, posts
        assert posts[0].title == @post_turtles.title
        assert posts[-1].title == @post_turtles.title
        
        refute pagination.has_newer
        assert pagination.has_older

        pagination = Services::Pagination.new(pagination.construct_page_token, @topic_turtles.id)
        posts = pagination.older
        assert posts.length == 1
        assert posts[0].title == @post_turtles.title

        refute pagination.has_older
        assert pagination.has_newer

        pagination = Services::Pagination.new(pagination.construct_page_token, @topic_turtles.id)
        posts = pagination.newer
        
        assert posts.length == 3
        sorted_posts = posts.sort_by { |post| -post.id }
        
        assert_equal sorted_posts, posts
        assert posts[0].title == @post_turtles.title
        assert posts[-1].title == @post_turtles.title

        assert pagination.has_older
        refute pagination.has_newer
    end
end
