module SoftDestroy
  def destroy
    self.is_deleted = true
    save
  end
end