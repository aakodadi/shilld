# shilld (shill server)

Shill-project is a CLI social network.

shilld is the server-side (backend). A web service developed as a
Ruby on Rails application.

[![Code Climate](https://codeclimate.com/github/akodakim/shilld/badges/gpa.svg)](https://codeclimate.com/github/akodakim/shilld)

[![Test Coverage](https://codeclimate.com/github/akodakim/shilld/badges/coverage.svg)](https://codeclimate.com/github/akodakim/shilld/coverage)

## License

All source code in this project is available under the MIT License. See
[LICENSE](LICENSE) for details.



## Related projects

+ [shill](https://github.com/akodakim/shill "shill") (shill client)

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
