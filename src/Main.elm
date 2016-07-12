port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



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
            ( model, outputToJS () )



-- SUBSCRIPTIONS


port outputToJS : () -> Cmd msg


port inputFromJS : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    inputFromJS GetCount



-- VIEW


exampleView : Model -> Html Msg
exampleView model =
    div
        [ class "col s4 offset-s4 card" ]
        [ h1 [ class "card-title" ] [ text <| "Port Example" ]
        , h3
            []
            [ text <| toString model.count ]
        , div [ class "card-action" ]
            [ a
                [ onClick DoCount ]
                [ text <| "Random" ]
            ]
        ]


exercise1View : Html Msg
exercise1View =
    div
        [ class "col s4 offset-s4 card" ]
        [ h1 [ class "card-title" ] [ text <| "Exercise 1" ]
        , h3
            []
            [ text <| "?" ]
        , div [ class "card-action" ]
            [ a
                []
                [ text <| "Calculate days" ]
            ]
        ]


exercise2View : Html Msg
exercise2View =
    div
        [ class "col s4 offset-s4 card" ]
        [ h1 [ class "card-title" ] [ text <| "Exercise 2" ]
        , div
            [ class "row" ]
            [ div [ class "input-field col s6" ]
                [ input [ id "date1", type' "text", placeholder "Date 1" ] []
                ]
            , div [ class "input-field col s6" ]
                [ input [ id "date2", type' "text", placeholder "Date 2" ] []
                ]
            ]
        , h3 [] [ text <| "?" ]
        , div [ class "card-action" ]
            [ a
                []
                [ text <| "Difference" ]
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "row" ]
        [ exampleView model
        , exercise1View
        , exercise2View
        ]
