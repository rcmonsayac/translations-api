class Api::V1::TranslationsController < ApplicationController
    #POST /translations
    def create_translation
      translation = Translation.new
      translation.source_language = Language.find_by(code: params["source_language_code"])
      translation.target_language = Language.find_by(code: params["target_language_code"])
      translation.glossary_id = params["glossary_id"]
      translation.source_text = params["source_text"]
  
      if translation.save
        render json: translation.id
      else
        render json: { error: 'Unable to create Translation' }, status: :bad_request
      end
    end
  
    #GET /translations/<id>
    def get_translation
      translation = Translation.find_by(id: params[:id])
      if translation.nil? 
        render json: { error: 'Unable to find Translation' }, status: :bad_request
      else
  
        if translation.glossary.nil?
            render json: 
              { 
                id: translation.id, 
                source_language_code: translation.source_language.code, 
                target_language_code: translation.target_language.code, 
                source_text: translation.source_text
              }
        else

          terms = translation.source_text.split
          glossary_terms = terms.select do |term|
            !Term.find_by(source: term, glossary_id: translation.glossary_id).nil?
          end
          
          highlighted_source_text = translation.source_text.clone
          glossary_terms.each do |glossary_term|
            highlighted_source_text.gsub! glossary_term, "<HIGHLIGHT>#{glossary_term}</HIGHLIGHT>"
          end

          render json: {
            id: translation.id, 
            source_language_code: translation.source_language.code, 
            target_language_code: translation.target_language.code, 
            source_text: translation.source_text,
            glossary_id: translation.glossary_id,
            glossary_terms: glossary_terms,
            highlighted_source_text: highlighted_source_text
          }
        end
      end
    end
end
