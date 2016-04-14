require 'spec_helper'

describe PagesController do
  render_views

before(:each) do
    @base_titre = "Ruby on Rails Tutorial Sample App"
  end

describe "GET 'help'" do
    it "devrait reussir" do
      get 'help'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'help'
      response.should have_selector("title",
    :content => "Simple App du Tutoriel Ruby on Rails | Aide en ligne")
    end
  end



  describe "GET 'home'" do

    describe "quand pas identifie" do

      before(:each) do
        get :home
      end

      it "devrait reussir" do
        response.should be_success
      end

      it "devrait avoir le bon titre" do
        response.should have_selector("title",
                        :content => "Simple App du Tutoriel Ruby on Rails | Accueil")

      end
    end

    describe "quand identifie" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => 								Factory.next(:email))
        other_user.follow!(@user)
      end

      it "devrait avoir le bon compte d'auteurs et de lecteurs" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 auteur suivi")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 lecteur")
      end
    end
  end

  describe "GET 'contact'" do
    it "devrait reussir" do
      get 'contact'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'contact'
      response.should have_selector("title",
                        :content =>
                          "Simple App du Tutoriel Ruby on Rails | Contact")
    end
  end

  describe "GET 'about'" do
    it "devrait reussir" do
      get 'about'
      response.should be_success
    end

    it "devrait avoir le bon titre" do
      get 'about'
      response.should have_selector("title",
                        :content =>
                          "Simple App du Tutoriel Ruby on Rails | A Propos")
    end
  end


end