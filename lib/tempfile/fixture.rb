require 'fileutils'
require 'tempfile'
require 'tempfile/fixture/version'

# Do a class eval to get around supercall mismatch across versions / implementations
# rubocop:disable Metrics/BlockLength
Tempfile.class_eval do

  ##
  # Fixture class for Tempfiles.
  #
  # @example Load a fixture file as a tempfile
  #
  #   Tempfile.Fixture('/path/to/data.txt').copy do |tempfile|
  #     # do something with the tempfile
  #   end
  #
  #   # the tempfile should be gone
  #
  # @example Don't unlink the tempfile
  #
  #   tempfile = Tempfile::Fixture.new('/path/to/data.txt').copy!
  #   tempfile # => the tempfile
  #
  class Fixture
    def initialize(path, tempfile_options: {})
      self.fixture = path
      self.tempfile_options = tempfile_options
    end

    def copy!
      file = Tempfile.new(tempfile_args, tempfile_options)
      FileUtils.copy_file(fixture, file.path, true)
      yield file if block_given?
      file
    end

    def copy(&block)
      file = copy!(&block)
      self
    ensure
      file.close unless file.closed?

      # Silently fail (hello windows)
      file.unlink rescue nil # rubocop:disable Style/RescueModifier

    end

    private

    def tempfile_args
      name = File.basename(fixture)
      ext = File.extname(fixture)

      # Some files don't have an extension!
      return name unless ext && ext.length.positive?

      [name, ext.start_with?('.') ? ext : ".#{ext}"]
    end

    attr_accessor :fixture, :tempfile_options
  end

  # noinspection RubyConstantNamingConvention
  TempfileFixture = Fixture

  # noinspection RubyClassMethodNamingConvention
  def self.Fixture(path, binary: false, &block)
    raise ArgumentError, 'no block given' unless block_given?
    raise ArgumentError, 'no path given' unless path && path.length.positive?
    encoding = binary ? 'ascii-8bit' : 'utf-8'

    TempfileFixture.new(path, tempfile_options: { encoding: encoding })
                   .copy(&block)
  end
end
# rubocop:enable Metrics/BlockLength
