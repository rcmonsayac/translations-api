require 'rails_helper'
require 'database_cleaner/active_record'

RSpec.describe Translation, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with :truncation, {only: ["glossaries"]}
    DatabaseCleaner.start
    @glossary = create(:glossary)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  context "Validations" do

    #validates creation of new translation
    it "1. valid new translation with glossary" do
      new_translation = build(:translation, glossary: @glossary)
      new_translation.save
      expect(new_translation).to be_valid
    end

    # validates presence of source text
    it "2. not valid if source text does not exist" do
      new_translation = build(:translation, glossary: @glossary, source_text: "")
      new_translation.save
      expect(new_translation.errors[:source_text]).to include("can't be blank")
    end

    #validates presence of source language without glossary
    it "3. not valid if source language does not exist" do
      new_translation = build(:translation, glossary: @glossary, source_language_id: nil)      
      new_translation.save
      expect(new_translation.errors[:source_language]).to include("must exist")
    end

    #validates presence of target language
    it "4. not valid if target language  does not exist" do
      new_translation = build(:translation, glossary: @glossary, target_language_id: nil)      
      new_translation.save
      expect(new_translation.errors[:target_language]).to include("must exist")
    end

    #validates if glossary languages are the same with source and target language
    it "5. not valid if glossary languages is not the same as the translation languages" do
      new_translation = build(:translation, glossary: @glossary, source_language_id:3, target_language_id: 4)      
      new_translation.save
      
      expect(new_translation.errors[:glossary_id]).to include("glossary language does not match translation language")
    end
  end
end

