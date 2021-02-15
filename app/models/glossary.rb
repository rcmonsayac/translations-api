class Glossary < ApplicationRecord
  belongs_to :source_language, class_name: 'Language'
  belongs_to :target_language, class_name: 'Language'
  has_many :terms
  has_many :translations
  validates :source_language, uniqueness: { scope: :target_language }
end
