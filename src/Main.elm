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
    { count : Int
    , countedDays : Int
    , difference : DateDifference
    , date1 : DateValue
    , date2 : DateValue
    }


init : ( Model, Cmd Msg )
init =
    ( { count = 0
      , countedDays = 0
      , difference =
            { years = 0
            , months = 0
            , days = 0
            }
      , date1 = ""
      , date2 = ""
      }
    , Cmd.none
    )


type alias NumberOfDays =
    Int


type alias DayDifference =
    String


type alias DateValue =
    String


type alias DateDifference =
    { years : Int
    , months : Int
    , days : Int
    }



-- UPDATE


type Msg
    = GetCount Int
    | DoCount
    | DoCountDays
    | CountDays NumberOfDays
    | UpdateDate1 DateValue
    | UpdateDate2 DateValue
    | CalculateDayDifference
    | UpdateDayDifference DateDifference


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetCount value ->
            ( { model | count = value }, Cmd.none )

        DoCount ->
            ( model, outputToJS () )

        UpdateDate1 value ->
            ( { model | date1 = value }, Cmd.none )

        UpdateDate2 value ->
            ( { model | date2 = value }, Cmd.none )

        DoCountDays ->
            ( model, countDays () )

        CountDays value ->
            ( { model | countedDays = value }, Cmd.none )

        CalculateDayDifference ->
            let
                { date1, date2 } =
                    model
            in
                ( model, calculateDateDifference ( date1, date2 ) )

        UpdateDayDifference difference ->
            ( { model | difference = difference }, Cmd.none )



-- SUBSCRIPTIONS


port outputToJS : () -> Cmd msg


port inputFromJS : (Int -> msg) -> Sub msg


port countDays : () -> Cmd msg


port daysCounted : (NumberOfDays -> msg) -> Sub msg


port calculateDateDifference : ( DateValue, DateValue ) -> Cmd msg


port dateDifference : (DateDifference -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ inputFromJS GetCount
        , daysCounted CountDays
        , dateDifference UpdateDayDifference
        ]



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


exercise1View : Model -> Html Msg
exercise1View model =
    div
        [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
        [ div [ class "mdl-card__title mdl-card--expand" ]
            [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 1" ]
            ]
        , h2
            [ class "result" ]
            [ text <| toString model.countedDays ]
        , div [ class "mdl-card__actions mdl-card--border" ]
            [ a
                [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick DoCountDays ]
                [ text "Calculate" ]
            ]
        ]


exercise2View : Model -> Html Msg
exercise2View model =
    let
        { years, months, days } =
            model.difference
    in
        div
            [ class "card-exercise1 mdl-card mdl-shadow--2dp mdl-cell mdl-cell--4-col mdl-cell--4-offset" ]
            [ div [ class "mdl-card__title mdl-card--expand" ]
                [ h2 [ class "mdl-card__title-text" ] [ text "Exercise 2" ]
                ]
            , div []
                [ div [ id "date1-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                    [ input [ id "date1", type' "text", class "mdl-textfield__input", placeholder "DD/MM/YYYY", value model.date1, onInput UpdateDate1 ] []
                    ]
                , div [ id "date2-wrapper", class "mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--10-col mdl-cell--1-offset" ]
                    [ input [ id "date2", type' "text", class "mdl-textfield__input", placeholder "DD/MM/YYYY", value model.date2, onInput UpdateDate2 ] []
                    ]
                ]
            , h2
                [ class "result" ]
                [ text <| toString years ++ " years"
                , br [] []
                , text <| " or " ++ toString months ++ " months"
                , br [] []
                , text <| " or " ++ toString days ++ " days"
                ]
            , div [ class "mdl-card__actions mdl-card--border" ]
                [ a
                    [ class "mdl-button mdl-js-button mdl-js-ripple-effect button", onClick CalculateDayDifference ]
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
