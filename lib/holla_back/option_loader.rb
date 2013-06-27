module HollaBack
  # Module of methods for loading options
  module OptionLoader
    # Loads one option into an instance variable and raises if it's missing the option
    #
    # @example
    #   load_option('foo', {:foo => 'bar'})
    #   @foo #=> 'bar'
    #
    # @param [String] option the name of the instance variable you want
    # @param [Hash] options the hash of options to fetch the value of the instance variable
    # @return [Class] the class type of the fetchted value in the options hash
    # @return [Exception] an exception will be raised if the option isn't found in the options hash
    # @api public
    def load_option(option, options)
      instance_variable_set("@#{option}", options.fetch(option.to_sym) { raise "Missing required option: #{option}" } )
    end

    # Loads multiple options in an array from an options hash
    #
    # @example
    #   load_options({:foo1 => 'bar1', :foo2 => 'bar2'}, :foo1, :foo2)
    #   @foo1 #=> 'bar1'
    #   @foo2 #=> 'bar2'
    #
    #
    # @param [Array] option_names the array of option names to fetch from the options hash
    # @param [Hash] options the hash of options which hold values for each option name
    # @return [Class] the class type of the fetched value in the options hash
    # @return [Exception] an exception will be raised if the option isn't found in the options hash
    # @see #load_option
    # @api public
    def load_options(options, *option_names)
      option_names.each{|o| load_option(o, options) }
    end

    module_function :load_option, :load_options
  end
end
