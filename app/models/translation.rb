class Translation < ApplicationRecord
  belongs_to :source_language, class_name: 'Language'
  belongs_to :target_language, class_name: 'Language'
  belongs_to :glossary, optional: true
  validate :validate_glossary
  validates :source_text, presence: true

  private
  def validate_glossary
    unless self.glossary_id.nil?
      glossary = Glossary.find_by(source_language_id: self.source_language_id, target_language_id: self.target_language_id)
      errors.add(:glossary_id, "glossary language does not match translation language") if glossary.nil? || glossary.id != self.glossary_id
    end
  end
end
