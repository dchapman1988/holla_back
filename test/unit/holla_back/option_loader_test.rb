require 'test_helper'

describe HollaBack::OptionLoader do
  subject { HollaBack::OptionLoader }

  it 'should load an option into an instance variable' do
    subject.load_option(:foo, {:foo => 'bar'})
    subject.instance_variable_defined?('@foo').must_equal true
    subject.instance_variable_get('@foo').must_equal 'bar'
  end

  it 'should load multiple options into many instance variables' do
    n = 0
    subject.load_options({:foo1 => 'bar1', :foo2 => 'bar2'}, :foo1, :foo2)
    [:foo1, :foo2].each do |v|
      n += 1
      subject.instance_variable_defined?("@#{v.to_s}").must_equal true
      subject.instance_variable_get("@#{v.to_s}").must_equal "bar#{n}"
    end
  end
end 
