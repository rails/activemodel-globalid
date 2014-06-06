require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/array/access'
require 'json'

module ActiveModel
  class GlobalID
    def self.create(model)
      id = {
        type: 'GlobalID',
        version: 1,
        class_name: model.class.name,
        id: model.id.to_s,
      }.to_json

      new id
    end

    def initialize(gid)
      @gid = gid
    end

    def model_class
      @model_klass ||= JSON.parse(@gid, symbolize_names: true)[:class_name].constantize
    end

    def model_id
      @model_id ||= JSON.parse(@gid, symbolize_names: true)[:id]
    end

    def ==(other_global_id)
      other_global_id.is_a?(GlobalID) && to_s == other_global_id.to_s
    end

    def to_s
      @gid
    end
  end
end

