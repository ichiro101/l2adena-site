require 'spec_helper'

describe Permission do

  it "should have id attribute" do
    permission = Permission.new
    permission.id = 5
    permission.id.should == 5
  end

  it "should return the correct types when asked for list" do
    permissions = Permission.all
    permissions.class.should == Array

    permission = permissions.first
    permission.class.should == Permission
  end

  it "should be able to find permission by symbol" do
    permission = Permission.find_by_symbol(:admin_panel)
    permission.should_not == nil
  end

end
