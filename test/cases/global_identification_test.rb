require 'helper'
require 'active_model/global_identification'

require 'models/person'
require 'models/book'

Person.send :include, ActiveModel::GlobalIdentification
Book.send :include, ActiveModel::GlobalIdentification

class GlobalIDTest < ActiveSupport::TestCase
  test 'global id' do
    @person = Person.new(5)
    @person.global_id.tap do |global_id|
      assert_equal Person, global_id.model_class
      assert_equal '5', global_id.model_id
    end
  end

  test 'global id (uuid)' do
    @person = Person.new('7ef9b614-353c-43a1-a203-ab2307851993')
    @person.global_id.tap do |global_id|
      assert_equal Person, global_id.model_class
      assert_equal '7ef9b614-353c-43a1-a203-ab2307851993', global_id.model_id
    end
  end

  test 'global id (string)' do
    @person = Person.new('foobar')
    @person.global_id.tap do |global_id|
      assert_equal Person, global_id.model_class
      assert_equal 'foobar', global_id.model_id
    end
  end


  test 'global id (custom primary key)' do
    @person = Book.new('0307463745')
    @person.global_id.tap do |global_id|
      assert_equal Book, global_id.model_class
      assert_equal '0307463745', global_id.model_id
    end
  end

  test 'global id (primary key not set)' do
    class Ebook
      include ActiveModel::GlobalIdentification
    end

    assert_raise(NoMethodError) {Ebook.new.global_id.model_id}
  end

end
