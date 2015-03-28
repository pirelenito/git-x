# git x (git times)

A simple bash script to run git commands into multiple nested git repositories.

It is great for projects that are split into multiple repositories.

The tool detects nested git repositories (one level deep) and run any command you pass to it on each nested repository:

```bash
git x status
git x checkout master
git x pull
```

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
