module Main exposing (..)

import Browser
import Update
import Model exposing (..)
import View

main : Program () Model Msg
main =
    Browser.element
        { view = View.view
        , init = \_ -> Model.init
        , update = Update.update
        , subscriptions = always Sub.none
        }
