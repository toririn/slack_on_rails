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
    context "【正常系】" do
      it "id で name への変換が出来ている" do
        current_user = user
        expect(User.convert(id: current_user.id)).to eq(current_user.name)
      end
      it "name で id の変換が出来ている" do
        current_user = user
        expect(User.convert(name: current_user.name)).to eq(current_user.id)
      end
    end

    context "【異常系】" do
      it "id に一致する name がないときに not found を返す" do
        current_user = user
        expect(User.convert(id: current_user.id.next)).to eq("not found")
      end
      it "name に一致する id がないときに not found を返す" do
        current_user = user
        expect(User.convert(name: current_user.name.chop)).to eq("not found")
      end
    end
  end
end
