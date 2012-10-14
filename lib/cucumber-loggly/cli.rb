require 'pathname'

module CucumberLoggly
  class CLI

    def initialize
      @feature_dir = Pathname.new('features').expand_path
      @feature     = ARGV.shift
    end

    def start
      unless File.exist? @feature
        puts "Error: feature file '#{@feature}' doesn't exist!"
        exit 1
      end

      exit 2 unless system run_command
    end

    private

    def run_command
      parts = []
      parts << "cucumber"
      parts << "--require #{@feature_dir}" if @feature_dir.exist?
      parts << "--format pretty" if ARGV.include?("--pretty")
      parts << @feature
      parts.join(' ')
    end

  end
end