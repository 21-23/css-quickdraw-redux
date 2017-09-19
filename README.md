# css-quickdraw-redux
![Travis build status](https://travis-ci.org/DaQuirm/css-quickdraw-redux.svg?branch=master)

CSS Selector Multiplayer Puzzle

## Installation

```sh
git clone git@github.com:21-23/css-quickdraw-redux.git
cd css-quickdraw-redux
npm i
./node_modules/.bin/bower i

cd ..
git clone git@github.com:DaQuirm/css-quickdraw-private.git
cd css-quickdraw-private
mongoimport --db cssqd-dev --collection puzzles --file ./docker/mongo-import/puzzles.json
mongoimport --db cssqd-dev --collection gamesessions --file ./docker/mongo-import/gamesessions.json

cd ../css-quickdraw-redux
./node_modules/.bin/webpack
npm run dev
```

* open http://localhost:3000/quick-login.html
* authorize any provider (e.g GitHub)
* find your user in mongo users collection
* update `game_master_id` field of gamesession in `gamesessions` collection with your user `_id`
* kill cssqd service
* copy gamesession `_id`
* `npm run dev`
* open http://localhost:3000/game?id=<gamesession_id>
* open the same url in different browser/incognito window
* authorize another provider (e.g Twitter)
* enjoy cssqd 😏

