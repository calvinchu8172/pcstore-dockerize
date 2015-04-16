module SoftDestroy
  def destroy
    self.is_deleted = true
    save(validate: false)
  end
end