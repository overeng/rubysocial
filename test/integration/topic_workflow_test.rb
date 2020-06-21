require 'test_helper'
require 'application_system_test_case'

class TopicWorkflowTest < ApplicationSystemTestCase 
  def setup
    @post_cats = create(:post, :about_cats)
    @post_dogs = create(:post, :about_dogs)
    @post_hamsters = create(:post, :about_hamsters)
    @post_turtles = create(:post, :about_turtles)
    @post_rabbits = create(:post, :about_rabbits)
  end

  test 'topic pages' do
    topics = [
        {
            "path" => "/posts/cats",
            "page_title" => "Котики",
            "post" => @post_cats
        },
        {
            "path" => "/posts/dogs",
            "page_title" => "Собачки",
            "post" => @post_dogs
        },
        {
            "path" => "/posts/hamsters",
            "page_title" => "Хомячки",
            "post" => @post_hamsters
        },
        {
            "path" => "/posts/turtles",
            "page_title" => "Черепашки",
            "post" => @post_turtles
        },
        {
            "path" => "/posts/rabbits",
            "page_title" => "Кролики",
            "post" => @post_rabbits
        }
    ]

    topics.each do |topic_data|
        visit topic_data["path"]
        page.has_content?(topic_data["page_title"])
        page.has_content?(topic_data["post"].title)
        page.has_content?(topic_data["post"].body)
    end
  end
end