class AddWizardStepAndLastStepToPollas < ActiveRecord::Migration[5.2]
  def change
    add_column :pollas, :wizard_step, :integer, default: 0
    add_column :pollas, :last_step, :integer, default: 1
  end
end
