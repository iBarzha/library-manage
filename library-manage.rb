class Book
  attr_accessor :title, :author, :status

  def initialize(title, author)
    @title = title
    @author = author
    @status = :available
  end

  def check_out
    @status = :checked_out
  end

  def check_in
    @status = :available
  end
end

class User
  attr_accessor :name, :borrowed_books

  def initialize(name)
    @name = name
    @borrowed_books = []
  end

  def borrow_book(book)
    if book.status == :available
      @borrowed_books << book
      book.check_out
      puts "#{@name} borrowed '#{book.title}' by #{book.author}."
    else
      puts "Sorry, '#{book.title}' is currently unavailable."
    end
  end

  def return_book(book)
    if @borrowed_books.include?(book)
      @borrowed_books.delete(book)
      book.check_in
      puts "#{@name} returned '#{book.title}' by #{book.author}."
    else
      puts "You have not borrowed '#{book.title}'."
    end
  end
end

class Library
  attr_accessor :books

  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
    puts "Added '#{book.title}' by #{book.author} to the library."
  end

  def display_available_books
    available_books = @books.select { |book| book.status == :available }
    puts "Available Books:"
    available_books.each { |book| puts "'#{book.title}' by #{book.author}" }
  end
end

# Sample Usage
book1 = Book.new("The Great Gatsby", "F. Scott Fitzgerald")
book2 = Book.new("To Kill a Mockingbird", "Harper Lee")
book3 = Book.new("1984", "George Orwell")

library = Library.new
library.add_book(book1)
library.add_book(book2)
library.add_book(book3)

user1 = User.new("Alice")
user2 = User.new("Bob")

library.display_available_books

user1.borrow_book(book1)
user2.borrow_book(book2)
user1.borrow_book(book2) # This should fail since book2 is already borrowed by Bob

library.display_available_books

user1.return_book(book1)
library.display_available_books
