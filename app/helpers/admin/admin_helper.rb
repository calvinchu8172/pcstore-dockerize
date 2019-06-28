module Admin::AdminHelper
  def edit_button(path)
    link_to t("Edit"), path, class: 'btn btn-default btn-xs'
  end

  def destroy_button(path)
    link_to t("Delete"), path, method: :delete, class: 'btn btn-danger btn-xs', data:{ confirm: t('Make_sure') }
  end

end