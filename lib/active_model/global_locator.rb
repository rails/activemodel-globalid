require 'active_model/global_id'
require 'active_model/signed_global_id'
require 'json'

module ActiveModel
  class GlobalLocator
    class << self
      # Takes either a GlobalID or a string that can be turned into a GlobalID
      def locate(gid)
        if gid.is_a? GlobalID
          gid.model_class.find(gid.model_id)
        elsif properly_formatted_gid?(gid)
          locate GlobalID.new(gid)
        end
      end
    
      # Takes either a SignedGlobalID or a string that can be turned into a SignedGlobalID
      def locate_signed(sgid)
        if sgid.is_a? SignedGlobalID
          sgid.model_class.find(sgid.model_id)
        else
          locate_signed SignedGlobalID.new(sgid)
        end
      end
      
      private
        def properly_formatted_gid?(gid)
          begin
            JSON.parse(gid)
            return true
          rescue => e
            return false
          end
        end
    end
  end
end
