class AddInstructionToCocktail < ActiveRecord::Migration[5.1]
  def change
    add_column :cocktails, :instruction, :string
  end
end
