require 'helper'
require 'active_model/signed_global_id'

require 'models/person'

ActiveModel::SignedGlobalID.verifier = ActiveSupport::MessageVerifier.new('muchSECRETsoHIDDEN')

class SignedGlobalIDTest < ActiveSupport::TestCase
  setup do
    @person_sgid = ActiveModel::SignedGlobalID.create(Person.new(5))
  end

  test 'string representation' do
    # TODO: This was cut-n-pasted from the test failure; I don't know enoough about Signed Messages to know if this is the correct value - daniel
    assert_equal 'BAhJIkN7InR5cGUiOiJHbG9iYWxJRCIsInZlcnNpb24iOjEsImNsYXNzX25hbWUiOiJQZXJzb24iLCJpZCI6IjUifQY6BkVU--77f3d9086c12b0f6a4c10305cf700347a1f2bac8', @person_sgid.to_s
  end

  test 'model id' do
    assert_equal "5", @person_sgid.model_id
  end

  test 'model class' do
    assert_equal Person, @person_sgid.model_class
  end

  test 'signed global ids equality' do
    assert_equal ActiveModel::SignedGlobalID.create(Person.new(5)), ActiveModel::SignedGlobalID.create(Person.new(5))
  end
end

