require File.expand_path(File.dirname(__FILE__) + '/../../../../../spec/spec_helper')

describe MemcachedProtected::ProtectedAccess do
  
  describe ".read" do

    it "should generate a protected key" do
      Rails.original_cache.should_receive(:read).with("58efdc201e7a8f6f621d47146beaa3d6186339b2")
      MemcachedProtected::ProtectedAccess.read("very big key"*251).should be_nil
    end

  end
  
  describe ".write" do

    it "should generate a protected key" do
      Rails.original_cache.should_receive(:write).with("58efdc201e7a8f6f621d47146beaa3d6186339b2", "content")
      MemcachedProtected::ProtectedAccess.write("very big key"*251, "content").should be_nil
    end

  end
  
end
