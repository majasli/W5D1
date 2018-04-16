require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do

    context "with good params" do
      it "if username + password are good redirect user to goals url" do
        post :create, params: { user: { username: "Maja", password: "starwars"  }}
        expect(response).to redirect_to(goals_url)
      end
    end

    context "with shitty params" do
      it "will validate the username and password" do
        post :create, params: { user: { username: "Maja", password: ""} }
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

  end

end
