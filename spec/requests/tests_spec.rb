require 'rails_helper'

RSpec.describe "Tests", type: :request do
  describe "GET /" do
    it "Bye, world!が表示されること" do
      get root_path
      expect(response.body).to include "Bye, world!"
    end
  end
end
