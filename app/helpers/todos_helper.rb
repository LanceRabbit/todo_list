module TodosHelper
    # 回傳刪除按鈕
  def todo_delete_button(todo)
    # 無法刪除的 todos 直接回傳 nil，不顯示按鈕
    return unless todo.can_destroy?
    link_to '', todo_path(todo), class: 'glyphicon glyphicon-remove', method: :delete, data: { confirm: 'Delete this item ?' }
  end

  # 回傳編輯按鈕, 暫時用不到
  def todo_edit_button(todo)
    link_to 'EDIT', edit_todo_path(todo), class: 'btn btn-info' , method: :get 
  end
end
