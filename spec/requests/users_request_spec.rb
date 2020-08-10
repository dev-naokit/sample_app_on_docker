require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET #new" do
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

  describe "POST #create" do
    context "パラメーターが妥当な場合" do
      let(:valid_params) { FactoryBot.attributes_for(:user, name: "test_user", email: "test_user@example.com", password: "password", password_confirmation: "password") }
      it "returns http success" do
        post users_path, params: { user: valid_params }
        expect(response).to have_http_status(302)
      end
      it "userが登録されること" do
        expect do
          post users_path, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end
      it "リダイレクトされること" do
        post users_path, params: { user: valid_params }
        expect(response).to redirect_to user_path(User.last)
      end
      it "メッセージが表示されること" do
        post users_path, params: { user: valid_params }
        follow_redirect!
        expect(response.body).to include "Welcome to the Sample App!"
      end
    end
    context "パラメーターが不正な場合" do
      let(:invalid_params) { FactoryBot.attributes_for(:user, 
        name:  "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar" ) }
      it "returns http success" do
        post users_path, params: { user: invalid_params }
        expect(response).to have_http_status(200)
      end
      it "userが登録されないこと" do
        expect do
          post users_path, params: { user: invalid_params }
        end.not_to change(User, :count)
      end
      it "errorが表示されること" do
        post users_path, params: { user: invalid_params }
        expect(response.body).to include "The form contains 4 errors."
      end
      it "emailが表示されること" do
        post users_path, params: { user: invalid_params }
        expect(response.body).to include invalid_params[:email]
      end
    end
  end
end
