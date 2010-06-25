module Rack
  module JSONP
  
    class StatusWrapper
      def initialize(app, callback_param = "_callback")
        @app, @callback_param = app, callback_param
      end
      
      def call(env)
        if env["jsonp.callback"]
          # Call original app
          status, headers, @body = @app.call(env)

          # Wrap
          @pre, @post = '{"body": ', ', "status": ' + status.to_s + '}'

          # Fix content length if present
          if content_length = headers["Content-Length"]
            headers["Content-Length"] = (@pre.size + content_length.to_i + @post.size).to_s
          end

          [status, headers, self]
        else
          @app.call(env)
        end
      end
      
      def each(&block)
        block.call(@pre)
        @body.each(&block)
        block.call(@post)
      end
    end
    
  end
end
