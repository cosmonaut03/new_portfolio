FactoryBot.define do
    factory :category do
  
      name { "test_folder" }
      position { 1 }
      is_uncategorized { false }
      user

    end
  
end