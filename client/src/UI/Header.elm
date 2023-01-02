module UI.Header exposing (header)

import Element exposing (Element, width, fill, centerX, row, paddingXY, el, alignRight, text, column, spacing)
import Element.Font as Font

import Model exposing (..)
import UI.Colors as Colors

name : Element Msg
name =
    column
        [ spacing 8
        , centerX
        ]
        [ el
            [ Font.color Colors.textColor
            , Font.size 30
            , Font.medium
            , centerX
            ]
            (text "André Danielsson")
        , el
            [ Font.color Colors.textColor
            , Font.size 18
            , Font.regular
            , centerX
            ]
            (text "Programmer")
        ]

header : Model -> Element Msg
header model =
    row
        [ width fill
        , centerX
        , paddingXY 0 16
        ]
        [ name ]
