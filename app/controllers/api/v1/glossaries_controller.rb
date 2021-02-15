class Api::V1::GlossariesController < ApplicationController

  # POST /glossaries
  def create_glossary
    glossary = Glossary.new
    glossary.source_language = Language.find_by(code: params["source_language_code"])
    glossary.target_language = Language.find_by(code: params["target_language_code"])


    if glossary.save
      render json: { id: glossary.id } 
    else
      render json: { error: 'Unable to create Glossary' }, status: :bad_request
    end
  end

  # GET /glossaries
  def get_all_glossaries
    all_glossaries_with_terms = Glossary.includes(:terms, :source_language, :target_language).all.map do |glossary|
      {
        id: glossary.id,
        source_language_code: glossary.source_language.code,
        target_language_code: glossary.target_language.code,
        terms: glossary.terms.map do |term|
          { id: term.id, source_term: term.source, target_term: term.target }
        end
      }
    end
    render json: all_glossaries_with_terms
  end

  #GET /glossaries/<id>
  def get_glossary
    glossary = Glossary.find_by(id: params[:id])
    if glossary.nil? 
      render json: { error: 'Unable to find Glossary' }, status: :bad_request
    else
      glossary_with_terms = Glossary.includes(:terms, :source_language, :target_language).find_by(id: params[:id])
      render json: { 
        id: glossary_with_terms.id,
        source_language_code: glossary_with_terms.source_language.code, 
        target_language_code: glossary_with_terms.target_language.code, 
        terms: glossary_with_terms.terms.map do |term|
          { id: term.id, source_term: term.source, target_term: term.target }
        end
      }
    end
  end

  #POST /glossaries/<id>/terms
  def create_term
    term = Term.new
    term.source = params["source_term"]
    term.target = params["target_term"]
    term.glossary_id = params[:id]
  
    if term.save
      render json: { id: term.id } 
    else
      render json: { error: 'Unable to create Term' }, status: :bad_request
    end
  end

end
