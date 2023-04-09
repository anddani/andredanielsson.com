# Personal website

* Backend - [Haskell](https://www.haskell.org/)
    * [servant](https://hackage.haskell.org/package/servant) - Define API as a type
* Frontend - [Elm](https://elm-lang.org/)
    * [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) - Wraps HTML and CSS
* Misc
    * [nix](https://nixos.org/) - Build frontend+backend, combining them in a docker container
    * [fly.io](https://fly.io/) - Hosting website

## TODO
- [ ] Implement blog functionality
    - [persistent](https://hackage.haskell.org/package/persistent) - Type safe postgres queries
    - [servant-elm](https://hackage.haskell.org/package/servant-elm) - Generate Elm functions to query and parse servant endpoints

# How to build

If on Apple Silicon:

`$ nix-shell`
