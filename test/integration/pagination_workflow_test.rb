require 'test_helper'
require 'application_system_test_case'

class PaginationWorkflowTest < ApplicationSystemTestCase 
  def setup
    @topic_cats = create(:topic, :cats)
    @topic_dogs = create(:topic, :dogs)
    @topic_hamsters = create(:topic, :hamsters)
    @topic_turtles = create(:topic, :turtles)
    @topic_rabbits = create(:topic, :rabbits)

    @post_cats = create_list(:post, 4, :about_cats, topic: @topic_cats)[0]
    @post_dogs = create_list(:post, 4, :about_dogs, topic: @topic_dogs)[0]
    @post_hamsters = create_list(:post, 4, :about_hamsters, topic: @topic_hamsters)[0]
    @post_turtles = create_list(:post, 4, :about_turtles, topic: @topic_turtles)[0]
    @post_rabbits = create_list(:post, 4, :about_rabbits, topic: @topic_rabbits)[0]
  end

  test 'index pagination' do
    visit "/"
    page.has_css?("card-body", count: 3)
    page.has_content?(@post_rabbits.title, count: 3)

    click_on "Более старые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_rabbits.title, count: 1)
    page.has_content?(@post_turtles.title, count: 2)

    click_on "Более старые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_turtles.title, count: 2)
    page.has_content?(@post_hamsters.title, count: 1)

    click_on "Более старые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_hamsters.title, count: 3)

    click_on "Более старые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 3)

    click_on "Более старые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 1)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Более старые"
    
    page.has_css?("card-body", count: 2)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Более новые"

    page.has_css?("card-body", count: 3)
    page.has_content?(@post_dogs.title, count: 1)
    page.has_content?(@post_cats.title, count: 2)

    click_on "Более новые"
    click_on "Более новые"
    click_on "Более новые"
    click_on "Более новые"
    page.has_css?("card-body", count: 3)
    page.has_content?(@post_rabbits.title, count: 3)
  end

  test 'topic pagination' do
    topics = [
        {
            "path" => "/posts/cats",
            "post" => @post_cats
        },
        {
            "path" => "/posts/dogs",
            "post" => @post_dogs
        },
        {
            "path" => "/posts/hamsters",
            "post" => @post_hamsters
        },
        {
            "path" => "/posts/turtles",
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
        page.has_content?(topic_data["post"].title, count: 3)
        click_on "Более старые"
        page.has_content?(topic_data["post"].title, count: 1)
        click_on "Более новые"
        page.has_content?(topic_data["post"].title, count: 3)
    end    
  end
end