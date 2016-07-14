port module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program (Maybe Model)
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { count : Int
    , difference : Int
    , firstField : String
    , secondField : String
    , differenceOfDates : Int
    }


initialModel : Model
initialModel =
    { count = 0
    , difference = 0
    , firstField = "01-07-2016"
    , secondField = "02-07-2016"
    , differenceOfDates = 0
    }


init : Maybe Model -> ( Model, Cmd Msg )
init passedModel =
    Maybe.withDefault initialModel passedModel ! []



-- UPDATE


type Msg
    = GetCount Int
    | DoCount
    | CalculateDifference
    | GetDifference Int
    | UpdateFirstField String
    | UpdateSecondField String
    | CalculateDifferenceBetweenDates
    | UpdateDifference Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCount value ->
            ( { model | count = value }, Cmd.none )

        DoCount ->
            let
                bar =
                    asdf
            in
                ( model, outputToJS () )

        CalculateDifference ->
            ( model, calculateDifference () )

        GetDifference diff ->
            ( { model | difference = diff }, Cmd.none )

        UpdateFirstField date ->
            ( { model | firstField = date }, Cmd.none )

        UpdateSecondField date ->
            ( { model | secondField = date }, Cmd.none )

        CalculateDifferenceBetweenDates ->
            ( model, calculateDifferenceBetweenDates [ model.firstField, model.secondField ] )

        UpdateDifference diff ->
            ( { model | differenceOfDates = diff }, Cmd.none )



-- Stuff nobody gets.


foo : (Int -> msg) -> String
foo asdf =
    "Hello World"


asdf : String
asdf =
    foo GetDifference



-- SUBSCRIPTIONS


port outputToJS : () -> Cmd msg


port calculateDifference : () -> Cmd msg


port calculateDifferenceBetweenDates : List String -> Cmd msg


port updateDifference : (Int -> msg) -> Sub msg


port inputFromJS : (Int -> msg) -> Sub msg


port getDifference : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ inputFromJS GetCount
        , getDifference GetDifference
        , updateDifference UpdateDifference
        ]



-- VIEW


exampleView : Model -> Html Msg
exampleView model =
    div [ class "card-example mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Port Example" ]
            ]
        , h2 [ class "result" ]
            [ text <| toString model.count ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick DoCount ]
                [ text "Random" ]
            ]
        ]


exercise1View : Model -> Html Msg
exercise1View model =
    div [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 1" ]
            ]
        , h2 [ class "result" ]
            [ text <| toString model.difference ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick CalculateDifference ]
                [ text "Calculate" ]
            ]
        ]


exercise2View : Model -> Html Msg
exercise2View model =
    div [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 2" ]
            ]
        , div []
            [ div [ id "date1-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                [ input [ id "date1", type' "text", class "mdl-textfield__input", placeholder model.firstField, onInput UpdateFirstField ] []
                ]
            , div [ id "date2-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                [ input [ id "date2", type' "text", class "mdl-textfield__input", placeholder model.secondField, onInput UpdateSecondField ] []
                ]
            ]
        , h2 [ class "result" ]
            [ text <| toString model.differenceOfDates ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick CalculateDifferenceBetweenDates ]
                [ text "Differenced" ]
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "mdl-grid" ]
        [ exampleView model
        , exercise1View model
        , exercise2View model
        ]
