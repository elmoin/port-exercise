port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
    { count : Int }


init : ( Model, Cmd Msg )
init =
    ( { count = 0 }, Cmd.none )



-- UPDATE


type Msg
    = GetCount Int
    | DoCount


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCount value ->
            ( { model | count = value }, Cmd.none )

        DoCount ->
            ( model, output () )



-- SUBSCRIPTIONS


port output : () -> Cmd msg


port input : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    input GetCount



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "row content" ]
        [ div
            [ class "col s10 offset-s1" ]
            [ h3 [ class "" ] [ text <| "Random count from JS: " ++ toString model.count ]
            , a
                [ class "waves-effect waves-light btn-large btn-more", onClick DoCount ]
                [ text <| "Get random from JS!" ]
            ]
        ]


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
