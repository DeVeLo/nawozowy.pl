# coding: utf-8
Rails.application.routes.draw do

  # instytucje: Okręgowe Stacje / CDRy
  resources :instytucje, only: [] do

    # rolnicy dostępni dla wszystkich
    # pracowników z poziomu instytucji
    # zarejestrowanych w systemie
    resources :rolnicy

    
  end
  
  resources :wojewodztwa, only: [:index]

  resources :wojewodztwa, only: [] do
    resources :powiaty, only: [:index]
  end

  resources :powiaty, only: [] do
    resources :gminy, only: [:index]
  end

  resources :rownowazniki

end
