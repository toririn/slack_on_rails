require 'rails_helper'
require 'spec_helper'

Rails.describe Service::SlackRails do
  describe '存在するかのテスト' do
    subject { slack_rails.nil? }
    let(:slack_rails) { Service::SlackRails.new }
    context "存在" do
      it { should be false }
    end
  end
end
