require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
    it "タイトルが表示されること" do
      get root_path
      assert_select "title", full_title
    end
    it "linkが適切に表示されること" do
      get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get help_path
      expect(response).to have_http_status(:success)
    end
    it "タイトルが表示されること" do
      get help_path
      assert_select "title", full_title("Help")
    end
    it "linkが適切に表示されること" do
      get help_path
      assert_template 'static_pages/help'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get about_path
      expect(response).to have_http_status(:success)
    end
    it "タイトルが表示されること" do
      get about_path
      assert_select "title", full_title("About")
    end
    it "linkが適切に表示されること" do
      get about_path
      assert_template 'static_pages/about'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get contact_path
      expect(response).to have_http_status(:success)
    end
    it "タイトルが表示されること" do
      get contact_path
      assert_select "title", full_title("Contact")
    end
    it "linkが適切に表示されること" do
      get contact_path
      assert_template 'static_pages/contact'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
    end
  end

end
