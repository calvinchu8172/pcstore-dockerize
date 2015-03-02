class Product < ActiveRecord::Base

  default_scope{ where(is_deleted: false) }

  def set_delete
    self.is_deleted = true
    save
  end

  def status
    if is_online
      "上架中"
    else
      "未上架"
    end
  end

end
