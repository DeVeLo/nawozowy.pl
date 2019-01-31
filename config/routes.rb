# coding: utf-8
Rails.application.routes.draw do

  resources :roslinaprzedplony
  resources :bobowate
  resources :zlecenia
  # na razie domyślnie wyświetlaj rolników z OSChR Lublin
  root "rolnicy#index", instytucja_id: "d04e8915-2ce7-45ee-b161-a7dcce79f65a"
  
  # instytucje: Okręgowe Stacje / CDRy
  resources :instytucje, only: [:show] do

    # rolnicy dostępni dla wszystkich
    # pracowników z poziomu instytucji
    # zarejestrowanych w systemie
    resources :rolnicy do

      # zlecenia w ramach instytucji
      resources :zlecenia do
        
        # zwierzęta w gospodarstwie
        resources :animals

        # pola z uprawami
        resources :uzytki
        
      end
    end
    
  end

  # warianty zlecenia
  resources :warianty, only: [:index]
  
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
  
end
