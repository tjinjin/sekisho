# Sekisho

[WIP]Management github milestone tools.

[![CircleCI branch](https://img.shields.io/circleci/project/github/tjinjin/sekisho/master.svg?style=flat-square)](https://circleci.com/gh/tjinjin/sekisho/tree/master)

# Install

  git clone git@github.com:tjinjin/sekisho.git
  bundle install

# Setup

```
cp sekisho_config.yml.sample sekisho_config.yml
vim sekisho_config.yml
```

Add your repositories in yaml file.


# Usage
## create
Create github milestones.

```
bundle exec sekisho --week 4 -c 8 -n
````

## close
Closed github milestones.

```
bundle exec sekisho close -n
```

For example

```
2017-12-01 <- milestone
  ├── issue1 open
  └── issue2 open
```

In this case, can't close milestone.

```
2017-12-01 <- milestone
  ├── issue1 close
  └── issue2 close
```

In this case, close milestone.

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
