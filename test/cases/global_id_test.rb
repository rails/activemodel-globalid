require 'helper'
require 'active_model/global_id'

require 'models/person'

class GlobalIDTest < ActiveSupport::TestCase
  setup do
    @uuid = '7ef9b614-353c-43a1-a203-ab2307851990'
    @person_gid = ActiveModel::GlobalID.create(Person.new(5))
    @person_uuid_gid = ActiveModel::GlobalID.create(Person.new(@uuid))
    @person_namespaced_gid = ActiveModel::GlobalID.create(Person::Child.new(4))
  end

  test 'string representation' do
    parsed = JSON.parse(@person_gid.to_s, symbolize_names: true)
    assert_equal 'GlobalID', parsed[:type]
    assert_equal 1, parsed[:version]
    assert_equal 'Person', parsed[:class_name]
    assert_equal '5', parsed[:id]
  end

  test 'string representation (uuid)' do
    parsed = JSON.parse(@person_uuid_gid.to_s, symbolize_names: true)
    assert_equal 'GlobalID', parsed[:type]
    assert_equal 1, parsed[:version]
    assert_equal 'Person', parsed[:class_name]
    assert_equal @uuid, parsed[:id]
  end

  test 'string representation (namespaced)' do
    parsed = JSON.parse(@person_namespaced_gid.to_s, symbolize_names: true)
    assert_equal 'GlobalID', parsed[:type]
    assert_equal 1, parsed[:version]
    assert_equal 'Person::Child', parsed[:class_name]
    assert_equal '4', parsed[:id]
  end

  test 'model id' do
    assert_equal '5', @person_gid.model_id
  end

  test 'model id (uuid)' do
    assert_equal @uuid, @person_uuid_gid.model_id
  end

  test 'model id (namespaced)' do
    assert_equal '4', @person_namespaced_gid.model_id
  end

  test 'model class' do
    assert_equal Person, @person_gid.model_class
  end

  test 'model class (uuid)' do
    assert_equal Person, @person_uuid_gid.model_class
  end

  test 'model class (namespaced)' do
    assert_equal Person::Child, @person_namespaced_gid.model_class
  end

  test 'global ids are values' do
    assert_equal ActiveModel::GlobalID.create(Person.new(5)), ActiveModel::GlobalID.create(Person.new(5))
  end

  test 'global ids are values (uuid)' do
    assert_equal ActiveModel::GlobalID.create(Person.new(@uuid)), ActiveModel::GlobalID.create(Person.new(@uuid))
  end

  test 'global ids are values (name_spaced)' do
    assert_equal ActiveModel::GlobalID.create(Person::Child.new(4)), ActiveModel::GlobalID.create(Person::Child.new(4))
  end
end

