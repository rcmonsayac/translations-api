require 'rails_helper'
require 'database_cleaner/active_record'


RSpec.describe Term, type: :model do
  before(:all) do
    DatabaseCleaner.clean_with :truncation, {only: ["glossaries", "terms"]}
    DatabaseCleaner.start
    @glossary = create(:glossary)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  context "Validations" do

    #validates creation of new term
    it "1. valid new source and target term and glossary" do
      new_term = build(:term, glossary: @glossary)
      new_term.save
      expect(new_term).to be_valid
    end

    # validates presence of source term
    it "2. not valid if source term does not exist" do
      new_term = build(:term, glossary: @glossary, source: nil)    
      new_term.save
      expect(new_term.errors[:source]).to include("can't be blank")
    end

    #validates presence of target term
    it "3. not valid if target term does not exist" do
      new_term = build(:term, glossary: @glossary, target: "")      
      new_term.save
      expect(new_term.errors[:target]).to include("can't be blank")
    end

    #validates presence of glossary
    it "4. not valid if glossary does not exist" do
      new_term = build(:term, glossary: nil)      
      new_term.save
      expect(new_term.errors[:glossary]).to include("must exist")
    end
  end
end

