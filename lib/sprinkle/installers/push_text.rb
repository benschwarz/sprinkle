module Sprinkle
  module Installers
    # Beware, strange "installer" coming your way.
    #
    # = Text configuration installer
    #
    # This installer pushes simple configuration into a file.
    # 
    # == Example Usage
    #
    # Installing magic_beans into apache2.conf
    #
    #   package :magic_beans do
    #     push_text 'magic_beans', '/etc/apache2/apache2.conf'
    #   end
    #
    # A special verify step exists for this very installer
    # its known as file_contains, it will test that a file indeed
    # contains a substring that you send it.
    #
    class PushText < Installer
      attr_accessor :text, :path #:nodoc:

      def initialize(parent, text, path, &block) #:nodoc:
        super parent, &block
        @text = text
        @path = path
      end

      protected

        def install_commands #:nodoc:
          "echo '#{@text}' | tee -a #{@path}"
        end

    end
  end
end
