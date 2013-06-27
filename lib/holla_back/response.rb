require "holla_back/option_loader"
module HollaBack
  attr_accessor :status, :status_message
  # The main class for providing response objects
  class Response
    include HollaBack::OptionLoader
    attr_accessor :responding_object, :responding_methods, :status_message

    # A new instance of HollaBack::Response
    #
    # @example
    #   response = HollaBack::Response.new({responding_object: SomeObject.new, status_message: 'valid?'})
    #
    # @param [Hash] options - a hash of options
    # @return [Response] the new response object
    # @api public
    def initialize(options)
      options = {
        responding_methods: [],
        success_message: nil,
        failure_message: nil,
      }.merge(options)
      load_options(options, :responding_object, :responding_methods, :status_method, :success_message, :failure_message)
      set_response!
    end

    # The status of success
    # 
    # @example
    #   response.success? #=> true
    #
    # @return [Boolean] true - if the status method is not nil or false
    # @return [Boolean] false - if the status method is nil or false
    # @api public
    def successful?
      !!@responding_object.send(@status_method)
    end

    # The response object
    #
    # @example
    #   response.response #=> #<HollaBack::Response>
    #
    # @return [HollaBack::Response] the response object
    def holla_back
      self
    end

    private
    # Sets the response attributes
    #
    # @example
    #   response.set_response! #=> #<HollaBack::Response>
    #
    # @api private
    def set_response!
      begin
        self.responding_object = @responding_object
        if successful?
          self.status_message = @success_message || "Status: successful"
        else
          self.status_message = @failure_message || "Status: unsuccessful"
        end
      rescue Exception => e
        self.responding_object = e.class
        self.status_message = e.message
      end
      get_responding_methods
    end

    # Gets the responding methods
    #
    # @example
    #   response.get_responding_methods
    # @return [Hash] a hash methods as keys and their return as values
    # @api public
    def get_responding_methods
      meth_responses = {}
      @responding_methods.each do |meth|
        begin
          if meth.is_a? Hash
            meth.each_pair { |k,v|
              meth_responses[k.to_sym] = @responding_object.send(k, *v)
            }
          else
            meth_responses[meth.to_sym] = @responding_object.send(meth)
          end
        rescue Exception => e
          if meth.is_a? Hash
            meth.each_pair { |k,v|
              meth_responses[k.to_sym] = "#{e.class}: #{e.message}"
            }
          else
            meth_responses[meth.to_sym] = "#{e.class}: #{e.message}"
          end
        end
      end
      self.responding_methods = meth_responses
    end
  end
end
