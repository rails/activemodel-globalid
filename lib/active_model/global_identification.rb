require 'active_model/global_id'
require 'active_model/signed_global_id'

module ActiveModel
  module GlobalIdentification
    extend ActiveSupport::Concern

    def global_id
      @global_id ||= GlobalID.create(self)
    end

    alias gid global_id

    def signed_global_id
      @signed_global_id ||= SignedGlobalID.create(self)
    end

    alias sgid signed_global_id

    module ClassMethods

      attr_writer :gid_primary_key

      def gid_primary_key
        @gid_primary_key ||= if respond_to?(:primary_key)
                               primary_key
                             elsif instance_methods.include?(:id)
                               :id
                             else
                             #   We should probably raise an error here

                             end
      end
    end
  end
end
