module UI.About exposing (about)

import Element exposing (Element, text, paddingXY, el, column, row, spacing, paragraph, none, fill, maximum, height, alignTop, alignBottom, alignLeft, alignRight, width, paddingEach, textColumn)
import Element.Font as Font

import Model exposing (..)
import UI.Colors as Colors
import UI.SideProjects as SP

aboutText : String
aboutText = """
Hi! I work as an Android developer.
On the side I dabble with functional programming in Haskell and Elm.
My passion is learning new things and this website is an attempt at exploring FP tools.
My goal is to document my journey along the way in an upcoming blog.
"""

aboutTitle : String -> Element Msg
aboutTitle value =
  el
    [ Font.color Colors.textColor
    , Font.size 38
    , Font.bold
    ]
    (text value)

aboutParagraph : String -> Element Msg
aboutParagraph value =
  paragraph
    [ Font.color Colors.textColor
    , Font.size 18
    , Font.regular
    , spacing 14
    ]
    [text value]

body : List String -> Element Msg
body values =
  textColumn
    [ Font.color Colors.textColor
    , Font.size 16
    , Font.regular
    , spacing 10
    ]
    (List.map (paragraph [ spacing 8 ] << List.singleton << text) values)

about : Model -> SP.WebpagePreviewState -> Element Msg
about model previewState =
  column
    [ paddingXY 0 48
    , spacing 32
    , height fill
    ]
    [ aboutTitle "About"
    , aboutParagraph aboutText
    , aboutTitle "Projects"
    , SP.sideProjects model previewState
    ]
