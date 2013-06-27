require "holla_back/version"
require "holla_back/response"
require "holla_back/option_loader"

# The main HollaBack module that all objects inherit from
module HollaBack
  # Callback invoked to define the response method in the including object
  def HollaBack.included(obj)
    obj.send(:define_method, 'response', instance_method(:holla_back))
  end

  # The holla back method for injecting into including classes/modules
  def holla_back(options={})
    HollaBack::Response.new(options)
  end
end
