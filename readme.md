## Houseparty

Sends Zoopla listings to Trello.

### Local installation

```sh
$ git clone git@github.com:tijmenb/houseparty.git
$ cd houseparty
$ bundle install
```

Run the tests:

```sh
bundle exec rspec
```

### Deploy

```sh
$ git clone git@github.com:tijmenb/houseparty.git
$ heroku create my-houseparty
$ git push heroku
```

## API Keys

You need a Zoopla API KEY, which you can acquire here:

  http://developer.zoopla.com/member/register/
