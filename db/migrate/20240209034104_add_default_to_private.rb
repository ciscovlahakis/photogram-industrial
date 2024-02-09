class AddDefaultToPrivate < ActiveRecord::Migration[7.0]
  def change
    change_column_default(
      table_name,
      column_name,
      default
    )
  end
end
