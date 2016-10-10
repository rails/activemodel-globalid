class Book
  attr_reader :isbn

  # Mocking ActiveRecord's primary_key
  def self.primary_key
    'isbn'
  end

  def self.find(isbn)
    new(isbn)
  end

  def initialize(isbn)
    @isbn = isbn
  end
end