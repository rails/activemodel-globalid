require 'helper'
require 'active_model/global_id'

require 'models/person'

class GlobalIDTest < ActiveSupport::TestCase
  setup do
    @person_gid = ActiveModel::GlobalID.create(Person.new(5))
  end

  test 'string representation' do
    assert_equal 'GlobalID-Person-5', @person_gid.to_s
  end

  test 'model id' do
    assert_equal '5', @person_gid.model_id
  end

  test 'model class' do
    assert_equal Person, @person_gid.model_class
  end

  test 'global ids are values' do
    assert_equal ActiveModel::GlobalID.create(Person.new(5)), ActiveModel::GlobalID.create(Person.new(5))
  end

end

class GlobalIDUUIDTest < ActiveSupport::TestCase
  setup do
    @uuid = '7ef9b614-353c-43a1-a203-ab2307851993'
    @person_uuid_gid = ActiveModel::GlobalID.create(Person.new(@uuid))
  end

  test 'string representation' do
    assert_equal "GlobalID-Person-#{@uuid}", @person_uuid_gid.to_s
  end

  test 'model id' do
    assert_equal @uuid, @person_uuid_gid.model_id
  end

  test 'model class' do
    assert_equal Person, @person_uuid_gid.model_class
  end

  test 'global ids are values' do
    assert_equal ActiveModel::GlobalID.create(Person.new(@uuid)), ActiveModel::GlobalID.create(Person.new(@uuid))
  end
end


class GlobalIDNamespacedTest < ActiveSupport::TestCase
  setup do
    @person_namespaced_gid = ActiveModel::GlobalID.create(Person::Child.new(4))
  end
  test 'string representation' do
    assert_equal 'GlobalID-Person::Child-4', @person_namespaced_gid.to_s
  end
  
  test 'model id' do
    assert_equal '4', @person_namespaced_gid.model_id
  end

  test 'model class' do
    assert_equal Person::Child, @person_namespaced_gid.model_class
  end

  test 'global ids are values' do
    assert_equal ActiveModel::GlobalID.create(Person::Child.new(4)), ActiveModel::GlobalID.create(Person::Child.new(4))
  end


end

class GlobalIDCustomIDTest < ActiveSupport::TestCase
  setup do
    @book_gid = ActiveModel::GlobalID.create(Book.new('0307463745'))
  end

  test 'string representation' do
    assert_equal 'GlobalID-Book-0307463745', @book_gid.to_s
  end

  test 'model id' do
    assert_equal '0307463745', @book_gid.model_id
  end

  test 'model class' do
    assert_equal Book, @book_gid.model_class
  end

  test 'global ids are values' do
    assert_equal ActiveModel::GlobalID.create(Book.new('0307463745')), ActiveModel::GlobalID.create(Book.new('0307463745'))
  end
end