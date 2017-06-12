## Houseparty

Sends Zoopla listings to Trello.

### 1. Clone the app

```sh
git clone git@github.com:tijmenb/houseparty.git
cd houseparty
cp .env.test .env
bundle install
```

### 2. Configure Trello

Visit https://trello.com/app-key and paste your Developer API Key into `.env` as `TRELLO_API_KEY`.

Run `bundle exec rake init_trello` and follow the instructions to get your `TRELLO_MEMBER_TOKEN`.

Finally, paste in a `TRELLO_BOARD_ID` into `.env`. It's the ID in `https://trello.com/b/<id>/your-board-name`.

### 3. Configure Zoopla

You need a `ZOOPLA_API_KEY` in the `.env`, which you can acquire here:

https://developer.zoopla.co.uk/member/register/

It can take a while before you get it.

### 4. Do a test run

```
bundle exec rake run
```
