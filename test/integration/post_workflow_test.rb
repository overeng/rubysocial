require 'test_helper'
require 'application_system_test_case'

class PostWorkflowTest < ApplicationSystemTestCase 
  def setup
    @post = create(:post, :about_cats)
    create(:topic, :dogs)
    create(:topic, :hamsters)
    create(:topic, :turtles)
    create(:topic, :rabbits)
  end

  test 'post show' do
    visit "/posts/" + @post.id.to_s

    assert page.has_content?(@post.title)
    assert page.has_content?(@post.body)
  end

  test 'successful post create and edit' do
    # creating post
    visit "/posts/new"

    fill_in "Заголовок", with: "Про моего хомяка"
    fill_in "Текст",  with: "История моего хомяка"
    select("Хомячки", from: "Выберите тему")

    click_on "Создать"

    post_id =  Post.last.id.to_s
    assert_current_path "/posts/" + post_id
    assert page.has_content?("Про моего хомяка")
    assert page.has_content?("История моего хомяка")

    # editing post
    visit "/posts/edit/" + post_id
    page.has_select?('post[topic]', selected: 'Хомячки')
    fill_in "Заголовок", with: "Про мою черепашку"
    fill_in "Текст",  with: "История моей черепашки"
    select("Черепашки", from: "Выберите тему")

    click_on "Сохранить"
    assert_current_path "/posts/" + post_id
    assert page.has_content?("Про мою черепашку")
    assert page.has_content?("История моей черепашки") 
    visit "/posts/edit/" + post_id
    page.has_select?('post[topic]', selected: 'Черепашки')
 end

 test 'post create validation errors' do
    # creating post
    visit "/posts/new"

    fill_in "Заголовок", with: ""
    fill_in "Текст",  with: ""
    
    click_on "Создать"

    assert page.has_content?("Заголовок не может быть пустым") 
    assert page.has_content?("Текст не может быть пустым") 

    fill_in "Заголовок", with: "x" * 301
    
    click_on "Создать"
    assert page.has_content?("Заголовок слишком длинный") 
 end

 test 'post edit validation errors' do
    # creating post
    visit "/posts/edit/" + @post.id.to_s

    fill_in "Заголовок", with: ""
    fill_in "Текст",  with: ""
    
    click_on "Сохранить"

    assert page.has_content?("Заголовок не может быть пустым") 
    assert page.has_content?("Текст не может быть пустым") 

    fill_in "Заголовок", with: "x" * 301
    
    click_on "Сохранить"
    assert page.has_content?("Заголовок слишком длинный") 
 end
end