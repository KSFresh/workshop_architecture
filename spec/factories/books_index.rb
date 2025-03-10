FactoryBot.define do
  factory :books_index do
    title { FFaker::Book.title }
    language { FFaker::Locale.code }
    authors { [[FFaker::NameRU.first_name, FFaker::NameRU.last_name].join(' ')] }
  end
end
