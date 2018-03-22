class View
  VERSION = '3.0.0'

  def View.version
    View::VERSION
  end

  def View.dependencies
    {
      'rails_current' => [ 'rails_current'    , '~> 1' ]
    }
  end
end
