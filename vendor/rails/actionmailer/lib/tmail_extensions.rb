#Here’s a monkey patch for TMail::Mail I wrote to recurse through a
#message and extract all plain text body components of that message,
#returning an Array. For most use cases, the resulting Array will
#contain one String element.

#Currently I put this code in a file called lib/tmail_extensions.rb and
#require ‘tmail_extensions’ in environment.rb

module TMail
   class Mail
     def plain_text_body
       gather_plain_text_parts(self).flatten
     end

   private
     def gather_plain_text_parts(part)
       returning [] do |message|
         message << part.body.strip if part.content_type == 'text/plain'
         part.parts.each { |p| message << gather_plain_text_parts(p) }
       end
     end
   end
 end