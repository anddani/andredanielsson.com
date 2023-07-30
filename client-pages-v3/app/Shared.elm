module Shared exposing (..)

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Element exposing (Element)
import Html.Events
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import UrlPath exposing (UrlPath)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import View exposing (View)
import Types
import Theme


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type alias Msg = Types.Msg


type alias Data =
    ()


type alias Model = Types.Model


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMenu = False }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Types.SharedMsg globalMsg ->
            ( model, Effect.none )

        Types.MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


-- TODO: Header+footer
view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { title = pageView.title
    , body = Theme.view { page = page, pageView = pageView, sharedData = sharedData } toMsg model pageView
    }
