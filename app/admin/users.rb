ActiveAdmin.register User do
  form do |f|
    f.inputs "User" do
      f.input :username
      f.input :password
      f.input :email
    end

    f.buttons
  end
end
