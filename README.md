# Rails Beginnings

[![CI](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml/badge.svg)](https://github.com/basecardhero/rails-beginnings/actions/workflows/ci.yml)

A beginner Ruby on Rails application I created to learn [Ruby](https://www.ruby-lang.org/en/), [Ruby on Rails](https://rubyonrails.org/), and [SQLite](https://www.sqlite.org/index.html).

### Objectives
- [X] Create a user authentication via `bin/rails generate authentication`.
- [ ] Create a user profile page.
- [ ] Create roles for authorization. User many-to-many Roles relationship.
- [ ] Create a `manage` section to manage users.
- [ ] ???

## Quick Start

1. Clone the repository and move into the direct via command line `cd rails-beginnings`.
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.
1. Run `bin/dev` to start the development environment.
1. Visit [http://localhost:3000](http://localhost:3000).
1. [Register](http://localhost:3000/registrations/new) a new user. _When registering a new user, the confirmation email will be available within your console logs. This will allow you to log in._

**Full command**
```
git clone git@github.com:basecardhero/rails-beginnings.git \
&& cd rails-beginnings \
&& bundle \
&& bin/rails db:migrate \
&& bin/dev
```

## Development

### Ruby Version

See [.ruby-version](.ruby-version) for the current Ruby version.

### Setup

1. Clone the repository and move into the directory via command line. Ex: `cd rails-beginnings`
1. Run `bundle` to install Gemfile dependencies.
1. Run `bin/rails db:migrate` to create and/or run database migrations.

## Testing

This project sticks with the default [Minitest](https://guides.rubyonrails.org/testing.html) library. I love [rspec](https://rspec.info/) and have been using it at work for the last five years, but I decided to try out Minitest.

#### Run unit tests
Uses default Rails Minitest library for unit tests.
```
bin/rails test
```

#### Run system (browser) tests
Uses [Capybara](https://github.com/teamcapybara/capybara) for running browser tests.
```
bin/rails test:system
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

#### Annotation
This project uses [annotaterb](https://github.com/drwl/annotaterb) gem to annotate models for documentation.

If database changes occurr, run the following to update the model annotation.
```
bundle exec annotaterb models --exclude
```

## Deployment

This will eventually use [Kamal](https://kamal-deploy.org/).

## Security

If you discover any security related issues, please email ryan@basecardhero.com instead of using the issue tracker.

## License

The [MIT License (MIT)](https://opensource.org/license/MIT). Please see [License File](LICENSE) for more information.
