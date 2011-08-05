require 'spec_helper'

describe User do

  it "user object can be created" do
    user = Factory(:user)
    user.should_not == nil
  end

  it "user can be authenticated" do
    user = Factory(:user)
    authenticated_user = User.authenticate("user", "som3secr3t")
    authenticated_user.should_not == nil

    authenticated_user.class.should == User
  end

  it "no users can have the same username" do
    user = Factory(:user)

    user2 = User.new
    user2.username = "user"
    user2.password = "something"
    user2.save.should == false
  end

end
