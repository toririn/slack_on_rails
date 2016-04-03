require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)            { create(:user)            }
  let(:empty_id_user)   { build(:empty_id_user)   }
  let(:empty_name_user) { build(:empty_name_user) }

  describe "CRUD操作" do

    context "【正常系】データ作成" do
      it "データの作成に成功する" do
        expect(user).to be_valid
      end
    end

    context "【異常系】データ作成" do
      it "id に値が入っていないときにエラーになる" do
        expect(empty_id_user).to be_invalid
      end
      it "name に値が入っていないときにエラーになる" do
        expect(empty_name_user).to be_invalid
      end
    end
  end

  describe "クラスメソッド" do
    context "【正常系】"
    it "user_id と user_name  の変換が出来ている" do
      expect(User.convert(id: user.id)).to eq(user.name)
    end
  end
end
