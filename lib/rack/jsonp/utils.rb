module Rack
  module JSONP

    module Utils
      def remove_param(env, param)
        env["QUERY_STRING"].gsub!(/#{Regexp.escape(param)}=[^&;]*/, "")
      end
      module_function :remove_param
    end

  end
end