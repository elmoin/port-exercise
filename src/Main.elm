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
        [ class "card-example mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Port Example" ]
            ]
        , h2
            [ class "result" ]
            [ text <| toString model.count ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a
                [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick DoCount ]
                [ text "Random" ]
            ]
        ]


exercise1View : Html Msg
exercise1View =
    div
        [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 1" ]
            ]
        , h2
            [ class "result" ]
            [ text "Result?" ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a
                [ class "mdl-button mdl-js-button mdl-js-ripple-effect button" ]
                [ text "Calculate" ]
            ]
        ]


exercise2View : Html Msg
exercise2View =
    div
        [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 2" ]
            ]
        , div []
            [ div [ id "date1-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                [ input [ id "date1", type' "text", class "mdl-textfield__input", placeholder "Date 1" ] []
                ]
            , div [ id "date2-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                [ input [ id "date2", type' "text", class "mdl-textfield__input", placeholder "Date 2" ] []
                ]
            ]
        , h2
            [ class "result" ]
            [ text "Result?" ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a
                [ class "mdl-button mdl-js-button mdl-js-ripple-effect button" ]
                [ text "Differenced" ]
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "mdl-grid" ]
        [ exampleView model
        , exercise1View
        , exercise2View
        ]
