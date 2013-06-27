require_relative "../lib/holla_back/version"
require_relative "../lib/holla_back/response"
require_relative "../lib/holla_back/option_loader"

# The main HollaBack module that all objects inherit from
module HollaBack
  # Callback invoked to define the response method in the including object
  # @example
  #   class SomeClass; include HollaBack; end
  #
  # @param [Object] obj - the object that included HollaBack
  # @return [HollaBack::Response] - a new HollaBack::Response object
  # @api public
  def HollaBack.included(obj)
    obj.instance_eval do
      define_method(:response) { |responding_obj=self, options|
        HollaBack::Response.new(responding_obj, options)
      }
    end
  end
end
