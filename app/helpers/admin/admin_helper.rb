module Admin::AdminHelper
  def edit_button(path)
    link_to "編輯", path, class:'btn btn-default btn-xs'
  end

  def destroy_button(path)
    link_to "刪除", path, method: :delete, class:'btn btn-danger btn-xs', data:{ confirm: '確認刪除？！'}
  end

end