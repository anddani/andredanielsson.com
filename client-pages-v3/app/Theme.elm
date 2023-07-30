module Theme exposing (..)

import Html exposing (Html)
import Types exposing (Msg)
import Element exposing (..)
import Element.Font as Font
import View exposing (View)


view : a -> (Msg -> wrapperMsg) -> Types.Model -> View wrapperMsg -> List (Html wrapperMsg)
view x toWrapperMsg model static =
  [ layout
      [ width fill
      , Font.size 17
      ]
    <|
      column [ width fill ] static.body
  ]
      


