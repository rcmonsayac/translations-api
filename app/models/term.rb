class Term < ApplicationRecord
  validates :source, presence: true
  validates :target, presence: true
  belongs_to :glossary
end
