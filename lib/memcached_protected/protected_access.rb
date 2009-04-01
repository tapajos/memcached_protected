class MemcachedProtected::ProtectedAccess
  
  MAX_KEY_SIZE = 247
  
  class << self

    def read(key)
      if valid_key?(key)
        Rails.original_cache.read(key) 
      else
        write_error key
        nil
      end
    end
    
    def write(key, content)
      if valid_key?(key)
        Rails.original_cache.write(key, content)
      else
        write_error key
      end
    end
    
    private
    
      def write_error(key)
        Rails.logger.error "-" * 80
        Rails.logger.error "Memcache key is too long."
        Rails.logger.error "key size: #{key.size}"
        Rails.logger.error "key: #{key}"
      end
    
      def valid_key?(key)
        key.kind_of?(String) && key.size <= MAX_KEY_SIZE 
      end
    
  end
  
  
end