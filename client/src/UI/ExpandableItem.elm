module UI.ExpandableItem exposing (view, ExpandableItem)

import Element exposing (Element, spacing, row, width, fill, el, paragraph, text, none, column, centerX, mouseOver, pointer, newTabLink)
import Element.Border as Border
import Element.Font as Font
import Element.Events as Events
import UI.Colors as Colors
import Model exposing (..)

type alias ExpandableItem =
  { title : String
  , description : String
  , content : Element Msg
  , sectionType : ProjectSection
  , expanded : Bool
  }

url : ProjectSection -> String
url s =
  case s of
    Homepage -> "https://github.com/anddani/andredanielsson.com"
    KeyboardPCB -> "https://github.com/anddani/media-controller"
    HapticsGame -> "https://github.com/anddani/Haptics_Atom"
    InvoiceProcessor -> "https://github.com/anddani/platinum-organizer"

section : ExpandableItem -> Element Msg
section item =
  row
    [ spacing 12
    , width fill
    ]
    [ el
      [ Font.size 16
      , pointer
      , Events.onClick <| ToggleExpandableSection item.sectionType
      ]
      (text <| if item.expanded then "▼" else "►")
    , paragraph
      []
      [ newTabLink
        [ Font.bold
        , Border.color Colors.background
        , Border.widthEach
          { bottom = 1
          , left = 0
          , top = 0
          , right = 0
          }
        , pointer
        , mouseOver
          [ Font.color Colors.highlight
          , Border.color Colors.highlight
          ]
        ]
        { url = url item.sectionType
        , label = text item.title
        }
      , text ": "
      , el [ Font.regular ] <| text item.description
      ]
    ]

view : Model -> ExpandableItem -> Element Msg
view model item =
  column
    [ spacing 8
    , width fill
    ]
    [ section item
    , if item.expanded then
        item.content
      else
        none
    ]
