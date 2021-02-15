class Language < ApplicationRecord
  has_many :source_language_glossaries, class_name: 'Glossary', foreign_key: 'source_language_id'
  has_many :target_language_glossaries, class_name: 'Glossary', foreign_key: 'target_language_id'

  has_many :source_language_translations, class_name: 'Translation', foreign_key: 'source_language_id'
  has_many :target_language_glossaries, class_name: 'Translation', foreign_key: 'target_language_id'

end
