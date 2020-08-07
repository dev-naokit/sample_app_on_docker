require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get sign_up_path
      expect(response).to have_http_status(:success)
    end
    it "returns correct page title" do
      get sign_up_path
      assert_template 'users/new'
      assert_select 'title', full_title("Sign up")
    end
  end

end
