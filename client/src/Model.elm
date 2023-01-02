module Model exposing (..)

type Msg
  = ToggleExpandableSection ProjectSection
  | HoverFooterItemEnter FooterItem
  | HoverFooterItemLeave

type FooterItem
  = GitHub
  | LinkedIn
  | Letterboxd
  | Goodreads

type ProjectSection
  = Homepage
  | KeyboardPCB
  | HapticsGame
  | InvoiceProcessor


type alias Model =
  { expandedSections : List ProjectSection
  , highlightedFooterItem : Maybe FooterItem
  }

init : ( Model, Cmd Msg )
init =
  let
    initialModel =
      { expandedSections = []
      , highlightedFooterItem = Nothing
      }
   in
     ( initialModel, Cmd.none )
