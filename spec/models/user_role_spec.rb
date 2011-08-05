require 'spec_helper'

describe UserRole do

  it "has user_id attribute" do
    user_roles = UserRole.new
    user_roles.user_id = 5
    user_roles.user_id.should == 5
  end
end
