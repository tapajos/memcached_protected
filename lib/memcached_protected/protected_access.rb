class MemcachedProtected::ProtectedAccess
  
  class << self

    def read(key)
      Rails.original_cache.read(generate_key(key)) 
    end
    
    def write(key, content)
      Rails.original_cache.write(generate_key(key), content)
    end
    
    private
    
      def generate_key(key)
        Digest::SHA1.hexdigest(key)
      end
    
  end
  
  
end