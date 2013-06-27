require 'test_helper'

describe HollaBack do
  subject { HollaBack }

  before do
    @test_class = TestClass.new
  end

  it 'should be included into a class' do
    @test_class.class.included_modules.must_include subject
  end

  it 'should inject a response method' do
    @test_class.must_respond_to :response
  end
end
