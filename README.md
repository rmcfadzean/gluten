# Gluten IRC bot.
An IRC bot using [Cinch](https://github.com/cinchrb/cinch) made for deployment on Heroku

## Installing
Clone the repository

```git clone git@github.com:wonderbread/gluten.git```

Initialize a Heroku instance

```herkou create```

Add memcache & redis to heroku

```
heroku addons:add memcachier && heroku addons:add rediscloud
```

Edit the `.env` file

```mv .env.sample .env```

Add the .env data to heroku

```
herkou config:add KEY=VALUE
```

Push to heroku

```git push heroku master && heroku scale bot=1```


# TODO
Tidy up
Rework plugins & Plugin module to make redis & http clients more native and gem including
