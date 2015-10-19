require 'rails' unless defined?(::Rails)
require 'action_controller' unless defined?(::ActionController)

class View
  VERSION = '2.1.0'

  def View.version
    View::VERSION
  end

  def View.load_shit!
    @loaded_shit ||= (
      unless defined?(::Rails)
        require 'rails'
      end

      unless defined?(::ActionController)
        require 'action_controller'
      end

      unless defined?(::ActionDispatch::TestRequest)
        require 'action_dispatch/testing/test_request.rb' 
      end

      unless defined?(::ActionDispatch::TestResponse)
        require 'action_dispatch/testing/test_response.rb' 
      end

      true
    )
  end

  if defined?(::Rails_current) && defined?(::Current)
    def View.controller(&block)
      controller = ::Current.controller || ::Current.mock_controller
      block ? controller.instance_eval(&block) : controller
    end
  else
    def View.controller(&block)
      load_shit!

      controller_class = Class.new(::ActionController::Base) do
        layout false
        helper :all
      end

      default_url_options =
        begin
          require 'rails_default_url_options'
          DefaultUrlOptions
        rescue LoadError
          options[:default_url_options] || {}
        end

      store = ActiveSupport::Cache::MemoryStore.new 
      request = ActionDispatch::TestRequest.new 
      response = ActionDispatch::TestResponse.new 

      controller = controller_class.new()

      controller.perform_caching = false
      controller.cache_store = store 
      controller.request = request 
      controller.response = response 
      #controller.send(:initialize_template_class, response) 
      #controller.send(:assign_shortcuts, request, response) 
      controller.send(:default_url_options).merge!(default_url_options)
      block ? controller.instance_eval(&block) : controller
    end
  end

  def View.render(*args)
    Array(View.controller{ render(*args) }).join.html_safe
  end
end

Rails_view = ::View

__END__
puts View.render(:inline => "<%= Time.now %> <%= link_to :foo, root_path %><%= solid :bar %><%= link_to :chiclet, Chiclet.first %>")
puts View.render(:inline => "* one\n* two\n* three\n", :type => :markdown)
