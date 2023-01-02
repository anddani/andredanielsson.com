module Update exposing (update)

import Model exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ToggleExpandableSection section ->
      let
        resultingExpandedSection =
          if List.member section model.expandedSections then
            List.filter (\s -> s /= section) model.expandedSections
          else
            section :: model.expandedSections
       in
         ( { model | expandedSections = resultingExpandedSection }, Cmd.none )

    HoverFooterItemEnter footerItem ->
      ( { model | highlightedFooterItem = Just footerItem }, Cmd.none )

    HoverFooterItemLeave ->
      ( { model | highlightedFooterItem = Nothing }, Cmd.none )
