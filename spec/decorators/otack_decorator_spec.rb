require 'spec_helper'

describe OtackDecorator do
  let(:otack) { Otack.new.extend OtackDecorator }
  subject { otack }
  it { should be_a Otack }
end
