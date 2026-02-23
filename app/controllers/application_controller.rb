class ApplicationController < ActionController::Base

  # Action de test pour BetterErrors (affiche une erreur volontaire)
  def test_error
    raise "YOLO_TEST"
  end

end