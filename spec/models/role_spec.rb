require 'spec_helper'

describe Role do

  it "can show me list of all roles" do
    roles = Role.all
    roles.class.should == Array

    role = roles.first
    role.class.should == Role
  end

  it "should have id attributes" do
    role = Role.new
    role.id = 1
    role.id.should == 1
  end

  it "should have symbol attributes" do
    role = Role.new
    role.symbol = :administrator
    role.symbol.should == :administrator
  end

  it "should have name attribute" do
    role = Role.new
    role.name = "Administrator"
    role.name.should == "Administrator"
  end

  it "should have has_all_permissions attribute" do
    role = Role.new
    role.has_all_permissions = true
    role.has_all_permissions.should == true
  end

  it "should be able to find roles" do
    role = Role.find_by_symbol(:admin)
    role.should_not == nil
    role.name.should == "Administrator"
  end

  it "should have owner, admin, and gamemaster role" do
    role = Role.find_by_symbol(:admin)
    role.should_not == nil

    role = Role.find_by_symbol(:owner)
    role.should_not == nil

    role = Role.find_by_symbol(:gamemaster)
    role.should_not == nil
  end

end
