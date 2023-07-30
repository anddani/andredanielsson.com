module Types exposing(..)

type Msg
  = SharedMsg SharedMsg
  | MenuClicked

type SharedMsg =
  NoOp

type alias Model =
  { showMenu : Bool
  }
