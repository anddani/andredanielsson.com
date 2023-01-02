module View exposing (view)

import Html exposing (Html)
import Html.Attributes exposing (style)
import Model exposing (..)
import FontAwesome.Styles as Icon
import Element exposing (Element, Color, el, text, row, alignRight, maximum, height, fill, width, rgb255, spacing, centerY, centerX, padding, column, none, paddingXY)
import Element.Background as Background
import Element.Font as Font

import UI.Colors as Colors
import UI.About exposing (about)
import UI.Header exposing (header)
import UI.Footer exposing (footer)
import UI.SideProjects as SP

defaultWebpagePreviewState : Model -> SP.WebpagePreviewState
defaultWebpagePreviewState model =
  { counter = 1
  , render = SP.PageRenderer <| about model
  }

page : Model -> Element Msg
page model =
  column
    [ width (fill |> maximum 750)
    , height fill
    , centerX
    ]
    [ header model
    , about model (defaultWebpagePreviewState model)
    , footer model
    ]

view : Model -> Html Msg
view model =
  Html.div [ style "height" "100%"]
    [ Icon.css
    , Element.layout
      [ Background.color Colors.background
      , paddingXY 0 60
      , height fill
      , Font.family
        [ Font.external
          -- { name = "Montserrat"
          -- , url = "https://fonts.googleapis.com/css?family=Montserrat"
          -- }
          -- { name = "Open sans"
          -- , url = "https://fonts.googleapis.com/css?family=Open%20Sans"
          -- }
          { name = "Merriweather"
          , url = "https://fonts.googleapis.com/css?family=Merriweather"
          }
        ]
      ]
      <| page model
    ]