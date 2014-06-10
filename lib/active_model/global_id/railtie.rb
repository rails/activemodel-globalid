require 'active_model/global_identification'

module ActiveModel
  class GlobalID
    # = Active Model GlobalID Railtie
    class Railtie < Rails::Railtie # :nodoc:
      initializer "active_model.globalid" do
        config.after_initialize do |app|
          ActiveModel::SignedGlobalID.verifier = app.message_verifier(:signed_global_ids)
        end

        ActiveSupport.on_load(:active_record) do
          send :include, ActiveModel::GlobalIdentification
        end
      end
    end
  end
end

