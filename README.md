# National Provider Search

A simple application which connects with NPPES NPI Registry to get data for National Providers.

### Dependencies

- Ruby `2.7.3`
- Rails `6.1.5`
- Yarn `1.22.10`
- PostgreSQL `13.6` (you could set your own database client on `config/database.yml`)

### Usage

Download the code, then:

- Run `bundle install` to install ruby dependencies;
- Run `yarn install` to install javascript dependencies;
- Run `rails db:setup` to setup initial database;
- Run `foreman start -f Procfile.dev` to start the local server;
- Visit `http:localhost:3000` to access the application.

### Running Tests

just run `rails spec` or `bundle exec rspec spec`.


