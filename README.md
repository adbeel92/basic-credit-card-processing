# Basic credit card processing

Credit card processing exercise developed by Eduardo Arenas

## Dependencies

* [RVM](https://rvm.io). RVM with version [1.29.12](https://rvm.io/blog/2021/01/rvm-1-29-12)

* [Ruby](https://www.ruby-lang.org/en/).  Written with version [3.1.4](https://www.ruby-lang.org/en/news/2023/03/30/ruby-3-1-4-released/) - *[docs](https://docs.ruby-lang.org/en/3.1/)*.

## Installation

- Install RVM: `\curl -sSL https://get.rvm.io | bash -s 1.29.12`.
- Run `rvm install ruby-3.1.4` to install ruby 3.1.4
- Clone the repository
- Create a gemset (entering to the directory, the gemset will be created thanks to the files `.ruby-version` and `.ruby-gemset`):
`cd ./basic-credit-card-processing` 
- Install deps: `gem install bundler -v 2.4 && bundle install`.

## Usage

* Run: `ruby main.rb` to run the program

  - Passing a filename, run `ruby main.rb input.txt`

  - Using the command-line (STDIN), run `ruby main.rb`
    - loading a filename, write `# > input.txt`
    - add a new card with single command-line, write `add name valid-card-number $1000`
    - charge an amount to a name, write `charge name $123`
    - credit an amount to a name, write `credit name $123`
    - press `q` or `q!` to exit

* Run: `rake` or `bundle exec rake` to run the rubocop and tests.
* Run: `rake rubocop` or `bundle exec rake rubocop`to run the rubocop.
* Run: `rake test` or `bundle exec rake test`to run the test.
