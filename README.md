# Rails Beginnings

[![CI](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml/badge.svg)](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml)

A beginner Ruby on Rails application I created to learn [Ruby](https://www.ruby-lang.org/en/), [Ruby on Rails](https://rubyonrails.org/), and [SQLite](https://www.sqlite.org/index.html).

### Objectives
- [X] Create a user authentication via `bin/rails generate authentication`.
- [ ] Create a user profile page.
- [ ] ...

## Quick Start

1. Clone the repository and move into the direct via command line.
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.
1. Run `bin/dev` to start the development environment.
1. Visit [http://localhost:3000](http://localhost:3000).
1. [Register](http://localhost:3000/registrations/new) a new user. _When registering a new user, the confirmation email will be available within your console logs. This will allow you to log in._

## Development

### Ruby Version

See [.ruby-version](.ruby-version) for the current Ruby version.

### Setup

1. Clone the repository and move into the direct via command line.
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.

### Testing

#### Run unit tests
The project uses default Rails mini test as the test library.
```
bin/rails test
```

#### Run a syntax check
To run Rubocop
```
bundle exec rubocop
```

#### Run a security scan
To run Brakeman
```
bin/brakeman --no-pager
```

## Deployment

This will eventually use [Kamal](https://kamal-deploy.org/).

## Security

If you discover any security related issues, please email ryan@basecardhero.com instead of using the issue tracker.

## License

The [MIT License (MIT)](https://opensource.org/license/MIT). Please see [License File](LICENSE) for more information.
