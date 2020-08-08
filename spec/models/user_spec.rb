require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    context "属性が妥当であれば登録できること" do
      subject(:user) { FactoryBot.create(:user) }
      it { is_expected.to be_valid }
    end
  end
  describe "name" do
    context "nameが存在しない場合はできないこと" do
      subject(:user) { FactoryBot.build(:user, name: "") }
      it { is_expected.to be_invalid }
    end
    context "nameが50文字の場合は登録できること" do
      subject(:user) { FactoryBot.build(:user, name: "a"*50) }
      it { is_expected.to be_valid }
    end
    context "nameが51文字の場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, name: "a"*51) }
      it { is_expected.to be_invalid }
    end
  end
  describe "email" do
    context "emailが存在しない場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, email: "") }
      it { is_expected.to be_invalid }
    end
    context "emailが255文字の場合は登録できること" do
      subject(:user) { FactoryBot.build(:user, email: "#{"a"*243}@example.com") }
      it { is_expected.to be_valid }
    end
    context "emailが256文字の場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, email: "#{"a"*244}@example.com") }
      it { is_expected.to be_invalid }
    end
    context "emailのフォーマットが妥当な場合" do
      it "登録できること" do
        valid_formats = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]
        valid_formats.each do |valid_format|
          expect(FactoryBot.build(:user, email: valid_format)).to be_valid
        end
      end
    end
    context "emailのフォーマットが不正な場合" do
      it "登録できないこと" do
        invalid_formats = %w[user@example,com user_at_foo.org user.name@example.
          foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_formats.each do |invalid_format|
          expect(FactoryBot.build(:user, email: invalid_format)).to be_invalid
        end
      end
    end
    context "emailが完全に重複する場合は登録できないこと" do
      let!(:existing_user) { FactoryBot.create(:user, email: "existing_email@example.com") }
      subject(:user) { FactoryBot.build(:user, email: "existing_email@example.com") }
      it { is_expected.to be_invalid }
    end
    context "大文字を含むemailが小文字に変換されて登録されること" do
      let!(:user) { FactoryBot.create(:user, email: "Foo@ExAMPle.CoM") }
      subject(:email) { User.last.email }
      it { is_expected.to eq "foo@example.com" }
    end
  end
  describe "password" do
    context "passwordが空の場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, password: password, password_confirmation: password) }
      let(:password) { "" }
      it { is_expected.to be_invalid }
    end
    context "passwordとpassword_confirmationが一致している場合は登録できること" do
      subject(:user) { FactoryBot.build(:user, password: password, password_confirmation: password) }
      let(:password) { "password" }
      it { is_expected.to be_valid }
    end
    context "passwordとpassword_confirmationが不一致の場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, password: password_correct, password_confirmation: password_error) }
      let(:password_correct) { "password" }
      let(:password_error) { "PASSWORD"}
      it { is_expected.to be_invalid }
    end
    context "passwordが5文字の場合は登録できないこと" do
      subject(:user) { FactoryBot.build(:user, password: password, password_confirmation: password) }
      let(:password) { "a"*5 }
      it { is_expected.to be_invalid }
    end
    context "passwordが6文字の場合は登録できること" do
      subject(:user) { FactoryBot.build(:user, password: password, password_confirmation: password) }
      let(:password) { "a"*6 }
      it { is_expected.to be_valid }
    end
  end
end
