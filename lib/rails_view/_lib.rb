class View
  VERSION = '3.2.0'

  def View.version
    View::VERSION
  end

  def View.dependencies
    {
      'rails_current' => [ 'rails_current'    , '~> 2' ]
    }
  end
end
