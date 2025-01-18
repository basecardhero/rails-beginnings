# Rails Beginnings

[![CI](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml/badge.svg)](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml)

A Ruby on Rails beginner application.

This is a project I created to learn Ruby and Ruby on Rails.

- User authentication flow
  - User registration (email confirmation)
  - User login
  - Password reset

## Quick Start

1. Clone the repository and move into the direct via command line.
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.
1. Run `bin/dev` to start the development environment.
1. Visit [http://localhost:3000](http://localhost:3000).
1. [Register](http://localhost:3000/registrations/new) a new user. _When registering a new user, the confirmation email will be available within your console. This will allow you to log in._

## Development

### Ruby Version

See [.ruby-version](.ruby-version) for the current Ruby version.

### Setup

1. Clone the repository and move into the direct via command line.
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.

### Testing

#### Unit tests
The project uses default Rails mini test as the test library.
```
bin/rails test
```

#### Syntax
To run Rubocop
```
bundle exec rubocop
```

#### Security
To run Brakeman
```
bin/brakeman --no-pager
```

## Deployment

Yet to come...
