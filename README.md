# git x (git times)

A simple bash script to run git commands into multiple nested git repositories.

It is great for projects that are split into multiple repositories.

The tool detects nested git repositories (one level deep) and run any command you pass to it on each nested repository:

```bash
git x status
git x checkout master
git x pull
```

## Motivation

It has become a common practice these days to break bigger projects into smaller ones. Take the example bellow:

```
.
├── README.md
├── frontend-app/
├── library-1/
├── library-2/
├── service-1/
└── service-2/
```

And while this approach makes it easier to maintain and deploy each project individually, it adds complexity to manage them all as "one". There are solutions like [foreman](http://ddollar.github.io/foreman/) and [docker-compose](https://github.com/docker/compose) that helps running them, but you still need to manage each Git repository individually.

This project's goal is to make it easy to run a git command on all these nested git repositories at once. So you can change branches, pull changes and check statuses; literally do everything you could if you would be running these commands on each nested folders.

So instead of doing:

```bash
git status

cd frontend-app
git status
cd ..

cd library-1
git status
cd ..

cd library-2
git status
cd ..

cd service-1
git status
cd ..

cd service-2
git status
cd ..
```

You can simply do:

```bash
git x status
```

It is [Git Submodules](http://www.git-scm.com/book/en/v2/Git-Tools-Submodules) without all the hassle.

## Cloning

It automatically creates a `.gitrepositories` file containing the url of all nested repositories, such as:

```
git@github.com:pirelenito/generator-react-webpack-component.git
git@github.com:pirelenito/react-transition.git
git@github.com:pirelenito/sagui.git
```

This file can be checked into source control and latter be used to clone all nested repositories:

```bash
git x clone
```

## Instalation

For simplicity, it is available as a NPM package:

```bash
npm install -g git-x
```

But since it is a simple bash script, you can simply download [the latest release](https://raw.githubusercontent.com/pirelenito/git-x/master/git-x.sh) and add it to your path.

```bash
curl -O https://raw.githubusercontent.com/pirelenito/git-x/master/git-x.sh
chmod +x git-x.sh
```
