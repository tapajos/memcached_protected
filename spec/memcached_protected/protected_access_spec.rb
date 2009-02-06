require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec/spec_helper')

describe MemcachedProtected::ProtectedAccess do
  
  describe ".read" do

    it "should log and return nil if key > 250" do
      Rails.original_cache.should_receive(:read).never
      Rails.logger.should_receive(:error).with("-" * 80)
      Rails.logger.should_receive(:error).with("Memcache key is too long.")
      Rails.logger.should_receive(:error).with("key size: 251")
      Rails.logger.should_receive(:error).with("key: #{"*"*251}")
      MemcachedProtected::ProtectedAccess.read("*"*251).should be_nil
    end
    
    def verify_valid_key(key)
      Rails.original_cache.should_receive(:read).with(key).and_return("fetched from cache")
      Rails.logger.should_receive(:error).never
      MemcachedProtected::ProtectedAccess.read(key).should == "fetched from cache"
    end

    it "should delegate to Rails.cache.read if key = 250" do
      verify_valid_key "*"*250
    end

    it "should delegate to Rails.cache.read if key < 250" do
      verify_valid_key "*"*249
    end

  end
  
  describe ".write" do

    it "should log when key > 250" do
      Rails.original_cache.should_receive(:write).never
      Rails.logger.should_receive(:error).with("-" * 80)
      Rails.logger.should_receive(:error).with("Memcache key is too long.")
      Rails.logger.should_receive(:error).with("key size: 251")
      Rails.logger.should_receive(:error).with("key: #{"*"*251}")
      MemcachedProtected::ProtectedAccess.write("*"*251, "content")
    end
    
    def write_valid_key(key)
      Rails.original_cache.should_receive(:write).with(key, "content")
      Rails.logger.should_receive(:error).never
      MemcachedProtected::ProtectedAccess.write(key, "content")
    end
    
    
    it "should delegate to Rails.cache.write if key = 250" do
      write_valid_key "*"*249
    end

    it "should delegate to Rails.cache.write if key = 250" do
      write_valid_key "*"*249
    end
    

  end
  
end
