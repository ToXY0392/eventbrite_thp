class BackfillValidatedEvents < ActiveRecord::Migration[8.1]
  def up
    # Événements existants avant la feature : considérés comme validés
    Event.where(reviewed: false).update_all(validated: true, reviewed: true)
  end

  def down
    # Irréversible
  end
end
