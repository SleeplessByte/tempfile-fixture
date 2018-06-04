require 'tempfile'

Tempfile.class_eval do
  class Fixture
    VERSION = '0.1.0'.freeze
  end
end
