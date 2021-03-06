module Analytical
  module Console
    class Api
      include Analytical::Base::Api

      def initialize(parent, options={})
        super
        @tracking_command_location = :body_append
      end

      def init_javascript(location)
        init_location(location) do
          js = <<-HTML
          <!-- Analytical Init: Console -->
          <script type="text/javascript">
            console.log('Analytical Init: Console');
          </script>
          HTML
          js
        end
      end

      def track(*args)
        "console.log(\"Analytical Track: \"+\"#{escape args.first}\");"
      end

      def identify(id, *args)
        data = args.first || {}
        "console.log(\"Analytical Identify: \"+\"#{id}\"+\" \"+$H(#{data.to_json}).toJSON());"
      end

      def event(name, *args)
        data = args.first || {}
        "console.log(\"Analytical Event: \"+\"#{name}\"+\" \"+$H(#{data.to_json}).toJSON());"
      end

      def set(data)
        "console.log(\"Analytical Set: \"+$H(#{data.to_json}).toJSON());"
      end

      private

      CONSOLE_JS_ESCAPE_MAP = {
        '\\' => '\\\\',
        '</' => '<\/',
        "\r\n" => '\n',
        "\n" => '\n',
        "\r" => '\n',
        '"' => '\\"',
        "'" => "\\'"
      }

      def escape(js)
        js.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { CONSOLE_JS_ESCAPE_MAP[$1] }
      end

    end
  end
end