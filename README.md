# Holla Back!

HollaBack is a simple Ruby gem that will provide a standard for responses 
in your classes/modules, and it can be configured with extra options for 
custom status messages, and methods that will be ran so that information 
from those methods can be included in your response object.

## Installation

Add this line to your application's Gemfile:

    gem 'holla_back'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holla_back

## Usage

Ponder the hypothetical class with HollaBack included that will be used for these examples:

> `some_class.rb`

```ruby
class SomeClass
  include HollaBack

  def truthy_method
    true
  end

  def falsey_method
    [nil, false].sample
  end

  def conditional_method_with_params(condition=nil)
    condition ? true : false
  end

  def info_method
    'some random info'
  end

  def optional_method
    'some random info'
  end

  def optional_method_with_params(param=nil)
    param ? true : false
  end
end
```


Simple example:

```ruby
klass = SomeClass.new

# Minimal request
response = klass.response(status_method: 'truthy_method') 
# => #<HollaBack::Response>
response.successful?
# => true
response.status_message
# => "Status: successful"
```

With params in the status method:

```ruby
klass = SomeClass.new

# Minimal request
response = klass.response(status_method: {optional_method_with_params: [true]}) 
# => #<HollaBack::Response>
response.successful?
# => true
response.status_message
# => "Status: successful"
```

With customized status messages:

```ruby
# If we have a truthy status method
response = klass.response(status_method: 'truthy_method', success_message: "It worked! :D", failure_message: "It didn't work! D:") 
# => #<HollaBack::Response>
response.successful?
# => true
response.status_message
# => "It worked! :D"

# If we have a falsy status method
response = klass.response(status_method: 'falsey_method', success_message: "It worked! :D", failure_message: "It didn't work! D:") 
# => #<HollaBack::Response>
response.successful?
# => false
response.status_message
# => "It didn't work! D:"
```

With extra methods you need information from

```ruby
response = klass.response(status_method: 'falsey_method', responding_methods: [:optional_method, {:optional_method_with_params => ['some param']}])
# => #<HollaBack::Response>
response.responding_methods
#=> {:optional_method=>"this was only optional", :optional_method_with_params=>true}
```

If you pass in a status method or some responding methods that raise exceptions, HollaBack will
simply handle these gracefully, because exceptions are still a response from your code. The important
one is your status message. If you want to force the error, then you call the `successful?` to force 
the exception on the status method, else you can check the responding object for the Exception.

With some method that totally doesn't exist

```ruby
response = klass.response(status_method: 'some_method_that_totally_doesnt_exist')
# => #<HollaBack::Response>
response.responding_object
#=> NoMethodError
response.status_message
#=> "undefined method `some_method_that_totally_doesnt_exist' for #<SomeClass:0x00000001e1b008>"
```

## Synopsis For Sending Methods

Synopsis for sending a method with parameters (the all important status method):

```ruby
# This is how you'd do it for the status method
{:name_of_status_method => ['array', 'of', 'input', 'parameters']}
```

Synopsis for sending multiple methods, some requiring parameters:

```ruby
# This is how you'd do it for the responding methods, which follows the same
# pattern as the status method, but as elements in an array so that you can
# respond with multiple responding methods
['name_of_some_method_with_no_params', {:name_of_some_method_with_params => ['array', 'of', 'input', 'parameters']}]
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
