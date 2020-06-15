## MarvelAPIMVVM
This project is a basic demonstration of the MVVM architecture in iOS. It demonstrates the usage of SwiftUI with Combine, as well as Unit Testing. 
The app consists of a list of the newest Marvel heroes, with it's own detail view with additional information.

## Build status
Build status of continus integration with Travis

[![Build Status](https://travis-ci.org/akashnimare/foco.svg?branch=master)](https://travis-ci.org/akashnimare/foco)
[![Windows Build Status](https://ci.appveyor.com/api/projects/status/github/akashnimare/foco?branch=master&svg=true)](https://ci.appveyor.com/project/akashnimare/foco/branch/master)

## Code style
MarvelAPIMVVM follows the SwiftLint Guidelines

[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)
 
## Screenshots

## Features
MVVM Architecture
SwiftUI & Combine usage
No third-party frameworks.
Unit Testing

## Installation
Make sure to install [SwiftLint](https://github.com/realm/SwiftLint) in order to enforce Swift style and conventions.

## API Reference
First need to sign up in https://developer.marvel.com and get your keys. 

To make request to the Marvel API, you need three parameters: "apikey", "ts" and "hash",.
- The apikey is just your public key
- Your ts (short for timestamp) can be anything, but it should be an actual timestamp. For example 2020-06-15
- To generate your hash use a MD5 [hash generator](https://www.md5hashgenerator.com/) with the following  "ts + privatekey + publickey" 

If you want more information regarding the Marvel API, make sure to check their documentation https://developer.marvel.com/docs

## Tests

## Contribute
If you want to help out and expand this project demonstration, feel free to create a Pull Request.