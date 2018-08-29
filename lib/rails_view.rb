
class View
  require_relative './rails_view/_lib.rb'

  begin
    require 'rubygems'
  rescue LoadError
    nil
  end

  require 'rails' unless defined?(::Rails)
  require 'action_controller' unless defined?(::ActionController)

  View.dependencies.each do |lib, dependency|
    gem(*dependency) if defined?(gem)
    require(lib)
  end

  def View.controller(&block)
    controller = ::Current.controller ? ::Current.controller.dup : ::Current.mock_controller
    block ? controller.instance_eval(&block) : controller
  end

  def View.render(*args)
    options = args.extract_options!.to_options!
    args.push(options)

    unless options.has_key?(:layout)
      options[:layout] = false
    end

    Array(View.controller{ render(*args) }).join.html_safe
  end
end

Rails_view = ::View

__END__
puts View.render(:inline => "<%= Time.now %> <%= link_to :foo, root_path %><%= solid :bar %><%= link_to :chiclet, Chiclet.first %>")
puts View.render(:inline => "* one\n* two\n* three\n", :type => :markdown)
