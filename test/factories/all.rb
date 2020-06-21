FactoryBot.define do
    factory :post do
      title { "Пост о котиках" }
      body  { "Много информации о котиках" }
      
      trait :about_cats do
        title { "Пост о котиках" }
        body  { "Много информации о котиках" }
        association :topic, factory: [:topic, :cats]
      end  
      trait :about_dogs do
        title { "Пост о собачках" }
        body { "Много информации о собачках" }
        association :topic, factory: [:topic, :dogs]
      end  
      trait :about_hamsters do
        title { "Пост о хомячках" }
        body { "Много информации о хомячках" }
        association :topic, factory: [:topic, :hamsters]
      end  
      trait :about_turtles do
        title { "Пост о черепашках" }
        body { "Много информации о черепашках" }
        association :topic, factory: [:topic, :turtles]
      end  
      trait :about_rabbits do
        title { "Пост о кроликах" }
        body { "Много информации о кроликах" }
        association :topic, factory: [:topic, :rabbits]
      end  
    end
    
    factory :topic do
        trait :cats do
          add_attribute(:alias) { "cats" }
          title { "Котики" }
        end  
        trait :dogs do 
          add_attribute(:alias) { "dogs" }
          title { "Собачки" }
        end  
        trait :hamsters do
          add_attribute(:alias) { "hamsters" }
          title { "Хомячки" }
        end  
        trait :turtles do
          add_attribute(:alias) { "turtles" }
          title { "Черепашки" }
        end  
        trait :rabbits do
          add_attribute(:alias) { "rabbits" }
          title { "Кролики" }
        end  
    end
  end