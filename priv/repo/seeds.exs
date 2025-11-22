# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LibraryStoreApp.Repo.insert!(%LibraryStoreApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LibraryStoreApp.Repo
alias LibraryStoreApp.Library.Book

# Clear existing books
Repo.delete_all(Book)

# Create sample books
books = [
  %{
    title: "The Phoenix Project",
    author: "Gene Kim, Kevin Behr, George Spafford",
    description: "A novel about IT, DevOps, and helping your business win.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/81QcZoA7R+L.jpg",
    published_year: 2013,
    isbn: "978-0988262508"
  },
  %{
    title: "Elixir in Action",
    author: "Saša Jurić",
    description: "Elixir in Action teaches you how to solve practical problems of scalability, concurrency, fault tolerance, and high availability using Elixir.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/81p1OvF4RZL.jpg",
    published_year: 2019,
    isbn: "978-1617295027"
  },
  %{
    title: "Programming Phoenix",
    author: "Chris McCord, Bruce Tate, José Valim",
    description: "Don't accept the compromise between fast and beautiful: you can have it all. Phoenix creator Chris McCord shows you how to build blazing fast, reliable, and maintainable applications.",
    cover_url: "https://pragprog.com/titles/phoenix14/programming-phoenix-1-4/phoenix14.jpg",
    published_year: 2019,
    isbn: "978-1680502268"
  },
  %{
    title: "Clean Code",
    author: "Robert C. Martin",
    description: "Even bad code can function. But if code isn't clean, it can bring a development organization to its knees.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/71W0bXlVHLL.jpg",
    published_year: 2008,
    isbn: "978-0132350884"
  },
  %{
    title: "The Pragmatic Programmer",
    author: "David Thomas, Andrew Hunt",
    description: "The Pragmatic Programmer is one of those rare tech books you'll read, re-read, and read again over the years.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/71VbyVNiMYL.jpg",
    published_year: 2019,
    isbn: "978-0135957059"
  },
  %{
    title: "Designing Data-Intensive Applications",
    author: "Martin Kleppmann",
    description: "Data is at the center of many challenges in system design today. Difficult issues need to be figured out, such as scalability, consistency, reliability, efficiency, and maintainability.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/91aJ+4b2DqL.jpg",
    published_year: 2017,
    isbn: "978-1449373320"
  },
  %{
    title: "Domain-Driven Design",
    author: "Eric Evans",
    description: "Eric Evans' Domain-Driven Design is a defining work in application software design, introducing the concept of Domain-Driven Design.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/61a36qKMDLL.jpg",
    published_year: 2003,
    isbn: "978-0321125217"
  },
  %{
    title: "Refactoring",
    author: "Martin Fowler",
    description: "Refactoring is about improving the design of existing code. It is the process of changing a software system in such a way that it does not alter the external behavior of the code yet improves its internal structure.",
    cover_url: "https://images-na.ssl-images-amazon.com/images/I/71VKi3uqMkL.jpg",
    published_year: 2018,
    isbn: "978-0134757599"
  }
]

Enum.each(books, fn book_attrs ->
  %Book{}
  |> Book.changeset(book_attrs)
  |> Repo.insert!()
end)

IO.puts("Seeded #{length(books)} books!")
