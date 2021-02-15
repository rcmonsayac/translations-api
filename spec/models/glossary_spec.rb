require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe Glossary, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with :truncation, {only: ["glossaries"]}
    DatabaseCleaner.start
    @glossary = create(:glossary)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  context "Validations" do

    #validates creation of new glossary
    it "1. valid new source and target language" do
      new_glossary = build(:glossary, source_language_id: 2, target_language_id: 3)
      new_glossary.save
      expect(new_glossary).to be_valid
    end

    #validates presence of source language
    it "2. not valid if source language does not exist" do
      new_glossary = build(:glossary, source_language_id: 1000, target_language_id: 3)
      new_glossary.save
      expect(new_glossary.errors[:source_language]).to include("must exist")
    end

    #validates presence of target language
    it "2. not valid if target language does not exist" do
      new_glossary = build(:glossary, source_language_id: 1, target_language_id: 1000)
      new_glossary.save
      expect(new_glossary.errors[:target_language]).to include("must exist")
    end

    #validates uniqueness of source and target language
    it "4. not valid if source and target language pair already exists" do
      duplicate_glossary = build(:glossary, source_language_id: 1, target_language_id: 2)
      duplicate_glossary.save
      expect(duplicate_glossary.errors[:source_language]).to include("has already been taken")
    end
  end
end

