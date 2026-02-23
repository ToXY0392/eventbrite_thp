Rails.application.routes.draw do
  
  # Route de test BetterErrors (pour vérifier l'affichage des erreurs)
  get "test_error", to: "application#test_error"

end