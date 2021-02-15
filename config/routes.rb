Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        post '/glossary', to: 'glossaries#create_glossary'
        get '/glossaries', to: 'glossaries#get_all_glossaries'
        get '/glossaries/:id', to: 'glossaries#get_glossary'
        post '/glossaries/:id/terms', to: 'glossaries#create_term'
        post '/translations', to: 'translations#create_translation'
        get '/translations/:id', to: 'translations#get_translation'
    end
  end
end
