require 'test_helper'

describe HollaBack::Response do
  describe "A successful response" do
    before do
      responding_object = mock('responding_object')
      responding_object.expects(:status_meth).returns(true).at_least_once
      responding_object.expects(:meth).returns(42).at_least_once
      responding_methods = ['meth']
      @options = {
        responding_object: responding_object,
        responding_methods: responding_methods,
        status_method: 'status_meth',
        success_message: 'success',
        failure_message: 'failure'
      }
      @response = HollaBack::Response.new(@options)
    end

    it 'should provide a successful status method' do
      @response.successful?.must_equal true
    end

    it 'should provide a response object' do
      @response.holla_back.must_be_kind_of HollaBack::Response
    end

    it 'should provide the responding methods' do
      @response.responding_methods.must_be_kind_of Hash
      @response.responding_methods[:meth].must_equal 42
    end

    it 'should return the success message' do
      @response.status_message.must_be_kind_of String
      @response.status_message.must_equal "success"
    end
  end

  describe "A unsuccessful response" do
    before do
      responding_object = mock('responding_object')
      responding_object.expects(:status_meth).returns([false, nil].sample).at_least_once
      responding_object.expects(:meth).returns(42).at_least_once
      responding_methods = ['meth']
      @options = {
        responding_object: responding_object,
        responding_methods: responding_methods,
        status_method: 'status_meth',
        success_message: 'success',
        failure_message: 'failure'
      }
      @response = HollaBack::Response.new(@options)
    end

    it 'should provide a successful status method' do
      @response.successful?.must_equal false
    end

    it 'should provide a response object' do
      @response.holla_back.must_be_kind_of HollaBack::Response
    end

    it 'should provide the responding methods' do
      @response.responding_methods.must_be_kind_of Hash
      @response.responding_methods[:meth].must_equal 42
    end

    it 'should return the success message' do
      @response.status_message.must_be_kind_of String
      @response.status_message.must_equal "failure"
    end
  end

  describe "A unsuccessful response due to a undefined methods" do
    before do
      responding_object = TestClass.new
      responding_methods = ['meth', 'class']
      @options = {
        responding_object: responding_object,
        responding_methods: responding_methods,
        status_method: 'unkown_status_meth',
        success_message: 'success',
        failure_message: 'failure'
      }
      @response = HollaBack::Response.new(@options)
    end

    it 'should return the exception class as the responding object' do
      @response.responding_object.must_equal NoMethodError
    end

    it 'should provide the error message as the response' do
      @response.status_message.must_be_kind_of String
    end
  end
end
