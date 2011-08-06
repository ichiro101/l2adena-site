require 'spec_helper'

describe PermissionRole do

  it "should have all the nessesary attributes" do
    pr = PermissionRole.new
    pr.permission_id = 1
    pr.role_id = 1
    pr.permission_id.should == 1
    pr.role_id.should == 1
  end
end
