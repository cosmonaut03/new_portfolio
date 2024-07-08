FactoryBot.define do
    factory :folder do
        name { "Sample Folder" }
        description { "This is a sample folder" }
        position { 1 }
        category
        user
    end
end
