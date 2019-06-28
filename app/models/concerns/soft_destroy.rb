module SoftDestroy
  def soft_destroy
    self.is_deleted = true
    save(validate: false)
  end
end