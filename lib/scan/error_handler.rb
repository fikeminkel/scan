module Scan
  # This classes methods are called when something goes wrong in the building process
  class ErrorHandler
    class << self
      # @param [String] The output of the errored build
      # This method should raise an exception in any case, as the return code indicated a failed build
      def handle_build_error(output)
        # The order of the handling below is import
        case output
        when /US\-ASCII/
          print "Your shell environment is not correctly configured"
          print "Instead of UTF-8 your shell uses US-ASCII"
          print "Please add the following to your '~/.bashrc':"
          print ""
          print "       export LANG=en_US.UTF-8"
          print "       export LANGUAGE=en_US.UTF-8"
          print "       export LC_ALL=en_US.UTF-8"
          print ""
          print "You'll have to restart your shell session after updating the file."
          print "If you are using zshell or another shell, make sure to edit the correct bash file."
          print "For more information visit this stackoverflow answer:"
          print "https://stackoverflow.com/a/17031697/445598"
        when /Testing failed/
          raise "Error building the application - see the log above".red
        end
        raise "Error building/testing the application - see the log above".red
      end

      private

      # Just to make things easier
      def print(text)
        Helper.log.error text.red
      end
    end
  end
end