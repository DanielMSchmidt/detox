#!/bin/bash

set -ex

echo "TRAVIS_PULL_REQUEST: $TRAVIS_PULL_REQUEST"
echo "TRAVIS_BRANCH: $TRAVIS_BRANCH"

if [[ "$TRAVIS_PULL_REQUEST" == "true" ]]; then
  echo 'Not deploying the website because this is a PR'; 
  exit 0; 
fi

if [[ "$TRAVIS_BRANCH" != "master" ]]; then 
  echo 'Not deploying the website because we are not on master'; 
  exit 0; 
fi

git config --global user.email "$GIT_USER@users.noreply.github.com";
git config --global user.name "Wix";
echo "machine github.com login $GIT_USER password $GIT_TOKEN" > ~/.netrc;
cd website;
npm install;
GIT_USER=$GIT_USER CURRENT_BRANCH=master npm run publish-gh-pages;
