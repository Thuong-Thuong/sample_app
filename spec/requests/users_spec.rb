require 'spec_helper'

describe "Users" do

  describe "Inscription" do

    describe "ratee" do

      it "ne devrait pas creer un nouvel utilisateur" do
        lambda do
          visit signup_path
          fill_in "Nom", :with => ""
          fill_in "Email", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

# describe "reussie" do

 #     it "devrait creer un nouvel utilisateur" do
  #      lambda do
  #        visit signup_path
  #        fill_in "Nom", :with => "Example User"
  #        fill_in "Email", :with => "user@example.com"
  #        fill_in "Password", :with => "foobar"
  #        fill_in "Confirmation", :with => "foobar"
  #        click_button
  #        response.should have_selector("div.flash.success",
  #         :content => "Bienvenue dans l'Application Exemple !")
  #        response.should render_template('users/show')
  #      end.should change(User, :count).by(1)
  #    end
  #  end
  
end

describe "identification/deconnexion" do

    describe "l'echec" do
      it "ne devrait pas identifier l'utilisateur" do
        visit signin_path
        fill_in "Email",    :with => ""
        fill_in "Password", :with => ""
        click_button
         response.should  
    have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "le succes" do
      it "devrait identifier un utilisateur puis le deconnecter" do
        user = Factory(:user)
        visit signin_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Deconnexion"
        controller.should_not be_signed_in
      end
    end
  end

end