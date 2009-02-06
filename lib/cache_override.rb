module Rails
  class << self
    
    alias_method :original_cache, :cache
    
    def cache
      MemcachedProtected::ProtectedAccess
    end
  end
end
