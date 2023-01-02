module UI.Colors exposing (..)

import Element exposing (Color, rgb255, rgba255)
import Html exposing (Attribute)
import Html.Attributes as HA

footer : Color
footer = rgb255 230 230 230

copyright : Color
copyright = rgb255 120 120 120

codeBlock : Color
codeBlock = rgb255 236 236 236

textColor : Color
textColor = rgb255 0 0 0

background : Color
background = rgb255 255 255 255

highlight : Color
highlight = rgb255 0 132 160

webpagePreviewBorder : Color
webpagePreviewBorder = rgba255 0 0 0 0.2

footerIconTint : Attribute msg
footerIconTint = HA.style "color" "rgb(0,0,0)"

footerIconTintHighlight : Attribute msg
footerIconTintHighlight = HA.style "color" "rgb(0,132,160)"
