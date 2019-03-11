# coding: utf-8
Rails.application.routes.draw do

  get "/monity/zabroniony", action: :zabroniony, controller: :monity, as: :zabroniony
  
  devise_for :users
  resources :wspiwykorzystania
  resources :nawozywykorzystane
  resources :animalgroups
  resources :roslinaprzedplony
  resources :bobowate
  resources :zlecenia
  
  # na razie domyślnie wyświetlaj rolników z OSChR Lublin
  root "application#welcome"
  
  # instytucje: Okręgowe Stacje / CDRy
  resources :instytucje, only: [:show] do

    # rolnicy dostępni dla wszystkich
    # pracowników z poziomu instytucji
    # zarejestrowanych w systemie
    resources :rolnicy do

      # zlecenia w ramach instytucji
      resources :zlecenia do

        member do
          delete :destroy_nawozynaturalne
        end
        
        # grupy zwierząt (w ramach grup nawóz naturalny jest zmieszany)
        resources :animalgroups do
          
          # zwierzęta w gospodarstwie
          resources :animals

        end

        # pola z uprawami
        resources :uzytki do

          # nawóz naturalny w ramach uprawy
          resources :nawozynaturalne
          
        end
        
      end
    end
    
  end

  # warianty zlecenia
  resources :warianty, only: [:index]

  # zlecenie podstawy zaopiniowania
  resources :podstawy, only: [:index]
  
  # na razie dostęp dla wszystkich
  resources :wojewodztwa, only: [:index]

  # na razie dostęp dla wszystkich
  resources :wojewodztwa, only: [] do
    resources :powiaty, only: [:index]
  end

  # na razie dostęp dla wszystkich
  resources :powiaty, only: [] do
    resources :gminy, only: [:index]
  end

  # na razie dostęp dla wszystkich
  resources :rownowazniki

  # gatunki zwierząt
  resources :gatunki, only: [:index] do
    resources :zwierzeta, only: [:index, :show] do
      resources :nazwyutrzymania, only: [:index] do
        resources :rownowazniki, only: [:index]
        resources :systemyutrzymania, only: [:index]
      end
    end
  end
  
  # rodzaje upraw
  resources :rodzajeuprawy, only: [:index] do
    # rośliny uprawne
    resources :rosliny, only: [:index]
  end
  
  resources :kategorie, only: [:index]
  resources :grunty, only: [:index]
  
end
