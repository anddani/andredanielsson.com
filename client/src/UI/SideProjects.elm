module UI.SideProjects exposing (sideProjects, WebpagePreviewState, PageRenderer(..))

import Model exposing (..)
import Element exposing (Element, width, fill, el, text, column, row, spacing, alignTop, paragraph, none, maximum, height, explain, image, centerX, html, clip, padding, scale, scrollbarY, minimum, paddingXY)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import UI.Colors as Colors
import UI.ExpandableItem as EI
import Html as Html
import Html.Attributes as HA

type alias WebpagePreviewState =
  { counter : Int
  , render : PageRenderer
  }

type PageRenderer = PageRenderer (WebpagePreviewState -> Element Msg)

-- TODO: Make this more generic
applyScale : Int -> Int -> Int
applyScale counter size =
  let
    res = case counter of
      3 -> 0.5
      2 -> 0.3
      1 -> 1
      0 -> 0.7
      _ -> 0.01
  in
    size * (round res)

next : WebpagePreviewState -> WebpagePreviewState
next state =
  { counter = state.counter - 1
  , render = state.render
  }

renderPreview : WebpagePreviewState -> Element Msg
renderPreview previewState =
  let
    (PageRenderer r) = previewState.render
   in
     r previewState
     
cornerRadius : Int
cornerRadius = 12

websitePreview : WebpagePreviewState -> Element Msg
websitePreview previewState =
  case previewState.counter of
    0 -> el [] none

    _ -> el
      [ Border.rounded 6
      , width (fill |> maximum 800)
      , height
        (fill
          |> maximum 1000
          |> minimum 1000
        )
      , scrollbarY
      , centerX
      , paddingXY 50 0
      , Border.rounded cornerRadius
      , Border.solid
      , Border.color Colors.webpagePreviewBorder
      , Border.width 1
      ]
      <| renderPreview (next previewState)

codeBlock : List String -> Element msg
codeBlock lines =
  column
    [ padding 10
    , Border.rounded cornerRadius
    , Border.color Colors.webpagePreviewBorder
    , Border.width 1
    , Font.family [ Font.monospace ]
    , width (fill |> maximum 500)
    , centerX
    ]
    <| List.map (\l -> el [ padding 2 ] (text l)) lines

screenshot : String -> String -> Element Msg
screenshot description url =
  image
    [ width (fill |> maximum 450)
    , centerX
    ]
    { src = url
    , description = description
    }

sideProjects : Model -> WebpagePreviewState -> Element Msg
sideProjects model previewState =
  let
      isExpanded : ProjectSection -> Bool
      isExpanded s = List.member s model.expandedSections

      projectPages : List EI.ExpandableItem
      projectPages =
        [ { title = "Homepage"
          , description = "Haskell + Servant, Elm + Elm-UI, Nix, fly.io"
          , content = websitePreview previewState
          , sectionType = Homepage
          , expanded = isExpanded Homepage
          }
        , { title = "Keyboard PCB design"
          , description = "KiCad"
          , content = screenshot "Screenshot of schematics in KiCad" "https://raw.githubusercontent.com/anddani/media-controller/master/media-controller-pic.png"
          , sectionType = KeyboardPCB
          , expanded = isExpanded KeyboardPCB
          }
        , { title = "Educational game for Novint Falcon"
          , description = "C++, Chai3d"
          , content = screenshot "Screenshot of educational game" "https://raw.githubusercontent.com/anddani/Haptics_Atom/master/screen.png"
          , sectionType = HapticsGame
          , expanded = isExpanded HapticsGame
          }
        , { title = "Invoice processor"
          , description = "Haskell, Cassava, Nix"
          , content = codeBlock
              [ "$ invoice-processor /path/to/invoice.csv"
              , "[ { card = \"Card holder 1\""
              , "  , amount = -123.45"
              , "  }"
              , ", { card = \"Card holder 2\""
              , "  , amount = -2345.67"
              , "  }"
              , "]"
              ]
          , sectionType = InvoiceProcessor
          , expanded = isExpanded InvoiceProcessor
          }
        ]
   in
   column
     [ Font.size (applyScale previewState.counter 18)
     , spacing 24
     ]
     <| List.map (EI.view model) projectPages
