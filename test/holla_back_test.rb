require 'test_helper'

describe HollaBack do
  subject { HollaBack }

  it 'should be a thing' do
    subject.must_be_kind_of Module
  end

  it 'should provide methods to a class' do
    TestClass.included_modules.must_include subject
  end
end
