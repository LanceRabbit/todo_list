class AddNoteToTodos < ActiveRecord::Migration[5.1]
  def change
    # 新增欄位 :  table_name , column_name, type
      add_column :todos, :note, :text
  end
end
