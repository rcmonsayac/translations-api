FactoryBot.define do

  factory :glossary do
    source_language_id { 1 }
    target_language_id { 2 }
  end
  
  factory :term do
    source { "source" }
    target { "target" }
    glossary
  end

  factory :translation do
    source_text { "the quick brown fox jumps over the lazy dog" }
    source_language_id { 1 }
    target_language_id { 2 }
    glossary
  end

end