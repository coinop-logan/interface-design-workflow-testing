module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { feedItems : List FeedItem
    }


type alias FeedItem =
    { id : Int
    , color : Color
    }


type Color
    = Red
    | Green
    | Blue
    | Yellow


init : Model
init =
    { feedItems =
        [ { id = 1, color = Red }
        , { id = 2, color = Green }
        , { id = 3, color = Blue }
        ]
    }



-- UPDATE


type Msg
    = SetFeedItemColor Int Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetFeedItemColor id color ->
            { model
                | feedItems =
                    List.map
                        (\item ->
                            if item.id == id then
                                { item | color = color }

                            else
                                item
                        )
                        model.feedItems
            }



-- VIEW


view : Model -> Html Msg
view model =
    layout [ padding 20, Background.color (rgb255 245 245 245) ] <|
        column [ width fill, spacing 20 ]
            [ viewHeader
            , viewFeed model.feedItems
            ]


viewHeader : Element Msg
viewHeader =
    row [ width fill ]
        [ el [ alignRight ] <|
            row [ spacing 10 ]
                [ viewProfilePic 40
                , el [ Font.size 16 ] (text "username")
                ]
        ]


viewFeed : List FeedItem -> Element Msg
viewFeed items =
    column [ width fill, spacing 15 ] <|
        List.map viewFeedItem items


viewFeedItem : FeedItem -> Element Msg
viewFeedItem item =
    row
        [ width fill
        , padding 15
        , spacing 15
        , Background.color (colorToRgb item.color)
        , Border.rounded 8
        ]
        [ viewProfilePic 50
        , column [ width fill, spacing 10 ]
            [ el [ height (px 60) ] (text "Feed item content area")
            , row [ alignRight, spacing 8 ]
                [ colorButton item.id Red
                , colorButton item.id Green
                , colorButton item.id Blue
                , colorButton item.id Yellow
                ]
            ]
        ]


viewProfilePic : Int -> Element Msg
viewProfilePic size =
    el
        [ width (px size)
        , height (px size)
        , Background.color (rgb255 200 200 200)
        , Border.rounded 4
        ]
        none


colorButton : Int -> Color -> Element Msg
colorButton itemId color =
    Input.button
        [ width (px 30)
        , height (px 30)
        , Background.color (colorToRgb color)
        , Border.rounded 4
        , Border.width 2
        , Border.color (rgb255 100 100 100)
        ]
        { onPress = Just (SetFeedItemColor itemId color)
        , label = none
        }


colorToRgb : Color -> Element.Color
colorToRgb color =
    case color of
        Red ->
            rgb255 255 200 200

        Green ->
            rgb255 200 255 200

        Blue ->
            rgb255 200 200 255

        Yellow ->
            rgb255 255 255 200
