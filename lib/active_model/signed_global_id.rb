require 'active_model/global_id'
require 'active_support/core_ext/module/attribute_accessors'
require 'json'

module ActiveModel
  class SignedGlobalID < GlobalID
    cattr_accessor :verifier

    def self.create(model)
      id = {
        type: 'GlobalID',
        version: 1,
        class_name: model.class.name,
        id: model.id.to_s,
      }.to_json

      new verifier.generate(id)
    end

    def initialize(sgid)
      @gid = self.class.verifier.verify(sgid)
    end
  
    def ==(other_global_id)
      other_global_id.is_a?(SignedGlobalID) && to_s == other_global_id.to_s
    end

    def to_s
      @sgid ||= self.class.verifier.generate(@gid)
    end
  end
end