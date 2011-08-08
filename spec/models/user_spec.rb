require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory(:user)
  end

  it "object can be created" do
    @user.should_not == nil
  end

  it "can be authenticated" do
    authenticated_user = User.authenticate("user", "som3secr3t")
    authenticated_user.should_not == nil

    authenticated_user.class.should == User
  end

  it "cannot be authenticated if password is wrong" do
    authenticated_user = User.authenticate("user", "wrongpassword")
    authenticated_user.should == nil
  end

  it "no users can have the same username" do
    user2 = User.new
    user2.username = "user"
    user2.password = "something"
    user2.save.should == false
  end

  it "can be assigned roles" do
    @user.assign_role(:owner)
    @user.has_role?(:owner).should == true
  end

  it "can be unassigned roles" do
    @user.assign_role(:admin)
    @user.has_role?(:admin).should == true

    @user.unassign_role(:admin)
    @user.has_role?(:admin).should == false
  end

  it "assigned to owner gives automatic access to admin panel" do
    role = Role.find_by_symbol(:owner)
    @user.assign_role(:owner)
    @user.has_role?(:owner).should == true
    @user.can_access?(:admin_panel).should == true
  end

  it "assigned to admin, and admin has admin_panel access, so user has admin panel access" do
    @user.assign_role(:admin)
    @user.has_role?(:admin).should == true

    role = Role.find_by_symbol(:admin)
    role.assign_permission(:admin_panel)

    @user.can_access?(:admin_panel).should == true
  end

  it "should not be able to access admin panel if user does not have role with that access" do
    @user.can_access?(:admin_panel).should == false
  end

end
