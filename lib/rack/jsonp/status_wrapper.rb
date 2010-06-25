module Rack
  module JSONP
  
    class StatusWrapper
      def initialize(app)
        @app = app
      end
      
      def call(env)
        if env["jsonp.callback"]
          # Call original app
          status, headers, @body = @app.call(env)

          # Wrap
          @pre, @post = '{"body": ', ', "status": ' + status.to_s + '}'

          # Fix content length if present
          content_length = headers["Content-Length"].to_i

          if content_length > 0
            headers["Content-Length"] = (@pre.size + content_length + @post.size).to_s
            [status, headers, self] # Override status
          else
            [status, headers, @body]
          end
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
