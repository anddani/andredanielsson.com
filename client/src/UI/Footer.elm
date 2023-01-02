module UI.Footer exposing (footer)

import Html exposing (Html, Attribute)
import Html.Attributes as HA
import Html.Events as HE
import Element exposing (Element, row, width, fill, centerX, text, column, el, spacing, html, alignBottom)
import UI.Colors as Colors
import Element.Font as Font

import Model exposing (..)

import FontAwesome.Attributes as Icon
import FontAwesome.Brands as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Icon as Icon

icon_ : FooterItem -> Icon.Icon
icon_ footerItem =
  case footerItem of
    GitHub -> Icon.github
    LinkedIn -> Icon.linkedinIn
    Letterboxd -> Icon.film
    Goodreads -> Icon.goodreadsG

url : FooterItem -> String
url footerItem =
  case footerItem of
    GitHub -> "https://github.com/anddani/"
    LinkedIn -> "https://www.linkedin.com/in/andr%C3%A9-danielsson-143286bb/"
    Letterboxd -> "https://letterboxd.com/anddani/"
    Goodreads -> "https://www.goodreads.com/user/show/75462134-andr-danielsson"

icon : FooterItem -> Model -> Element Msg
icon footerItem model =
  let
    highlighted : Bool
    highlighted = model.highlightedFooterItem == Just footerItem
   in
     Html.a
       [ Icon.stack
       , HA.style "cursor" <| if highlighted then "pointer" else "auto"
       , HA.target "_blank"
       , HA.href <| url footerItem
       , HE.onMouseEnter <| HoverFooterItemEnter footerItem
       , HE.onMouseLeave <| HoverFooterItemLeave
       ]
       [ Icon.viewStyled
         [ Icon.stack2x
         , if highlighted then Colors.footerIconTintHighlight else Colors.footerIconTint
         ]
         Icon.circle
       , Icon.viewStyled [ Icon.stack1x, Icon.inverse ] (icon_ footerItem)
       ]
       |> html

links : Model -> Element Msg
links model =
  row
    [ spacing 24
    , centerX
    ]
    [ icon GitHub model
    , icon LinkedIn model
    , icon Letterboxd model
    , icon Goodreads model
    ]

copyright : Element Msg
copyright =
  el
    [ Font.color Colors.copyright, Font.size 14 ]
    <| text "Copyright © 2022 André Danielsson"

footer : Model -> Element Msg
footer model =
  column
    [ spacing 24
    , centerX
    , alignBottom
    ]
    [ links model
    , copyright
    ]
