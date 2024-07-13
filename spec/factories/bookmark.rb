FactoryBot.define do
    factory :bookmark do
        title { "Sample Bookmark" }
        description { "This is a sample Bookmark" }
        url{ 'https://xdtrail.com/events/workshop-20200613/' }
        position { 1 }
        category
        folder
        user
    end

    trait :without_folder do
        folder_id { nil }
    end
end
