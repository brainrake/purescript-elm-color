module Elm.Color
    ( Color(..), rgb, rgba, hsl, hsla, greyscale, grayscale, complem
    , Gradient(..), linear, radial
    , toRgb, toHsl
    , red, orange, yellow, green, blue, purple, brown
    , lightRed, lightOrange, lightYellow, lightGreen, lightBlue, lightPurple, lightBrown
    , darkRed, darkOrange, darkYellow, darkGreen, darkBlue, darkPurple, darkBrown
    , white, lightGrey, grey, darkGrey, lightCharcoal, charcoal, darkCharcoal, black
    , lightGray, gray, darkGray
    ) where

{-| Library for working with colors. Includes
[RGB](https://en.wikipedia.org/wiki/RGB_color_model) and
[HSL](http://en.wikipedia.org/wiki/HSL_and_HSV) creation, gradients, and
built-in names.

# Creation
@docs rgb, rgba, hsl, hsla, greyscale, grayscale, complement

# Gradients
@docs linear, radial

# Extracting Colors
@docs toRgb, toHsl

# Built-in Colors
These colors come from the [Tango
palette](http://tango.freedesktop.org/Tango_Icon_Theme_Guidelines)
which provides aesthetically reasonable defaults for colors. Each color also
comes with a light and dark version.

### Standard
@docs red, orange, yellow, green, blue, purple, brown

### Light
@docs lightRed, lightOrange, lightYellow, lightGreen, lightBlue, lightPurple, lightBrown

### Dark
@docs darkRed, darkOrange, darkYellow, darkGreen, darkBlue, darkPurple, darkBrown

### Eight Shades of Grey
These colors are a compatible series of shades of grey, fitting nicely
with the Tango palette.
@docs white, lightGrey, grey, darkGrey, lightCharcoal, charcoal, darkCharcoal, black

These are identical to the *grey* versions. It seems the spelling is regional, but
that has never helped me remember which one I should be writing.
@docs lightGray, gray, darkGray

-}

import Prelude
import Elm.Basics (turns, degrees)
import Math (pi, max, min, abs)
import Data.Int (toNumber, floor, round)
import Data.Tuple (Tuple(..))


data Color
    = RGBA Int Int Int Number
    | HSLA Number Number Number Number

instance showColor :: Show Color where
  show (RGBA r g b a) = "(RGBA " ++ show r ++ " " ++ show g ++ " " ++ show b ++ " " ++ show a ++ ")"
  show (HSLA h s l a) = "(RGBA " ++ show h ++ " " ++ show s ++ " " ++ show l ++ " " ++ show a ++ ")"


{-| Create RGB colors with an alpha component for transparency.
The alpha component is specified with numbers between 0 and 1. -}
rgba :: Int -> Int -> Int -> Number -> Color
rgba = RGBA

{-| Create RGB colors from numbers between 0 and 255 inclusive. -}
rgb :: Int -> Int -> Int -> Color
rgb r g b = RGBA r g b 1.0

{-| Create [HSL colors](http://en.wikipedia.org/wiki/HSL_and_HSV)
with an alpha component for transparency.
-}
hsla :: Number -> Number -> Number -> Number -> Color
hsla hue saturation lightness alpha =
    HSLA (hue - turns (toNumber (floor (hue / (2.0*pi))))) saturation lightness alpha

{-| Create [HSL colors](http://en.wikipedia.org/wiki/HSL_and_HSV). This gives
you access to colors more like a color wheel, where all hues are aranged in a
circle that you specify with standard Elm angles (radians).

    red   = hsl (degrees   0) 1 0.5
    green = hsl (degrees 120) 1 0.5
    blue  = hsl (degrees 240) 1 0.5

    pastelRed = hsl (degrees 0) 0.7 0.7

To cycle through all colors, just cycle through degrees. The saturation level
is how vibrant the color is, like a dial between grey and bright colors. The
lightness level is a dial between white and black.
-}
hsl :: Number -> Number -> Number -> Color
hsl hue saturation lightness =
    hsla hue saturation lightness 1.0

{-| Produce a gray based on the input. 0 is white, 1 is black. -}
grayscale :: Number -> Color
grayscale p = HSLA 0.0 0.0 (1.0-p) 1.0

greyscale :: Number -> Color
greyscale p = HSLA 0.0 0.0 (1.0-p) 1.0

{-| Produce a &ldquo;complementary color&rdquo;. The two colors will
accent each other. This is the same as rotating the hue by 180&deg;.
-}
complem :: Color -> Color
complem color =
    case color of
      (HSLA h s l a) -> hsla (h + degrees 180.0) s l a
      (RGBA r g b a) -> case rgbToHsl r g b of
        (Tuple h (Tuple s l)) -> hsla (h + degrees 180.0) s l a

{-| Extract the components of a color in the HSL format.
-}
toHsl :: Color -> { hue::Number, saturation::Number, lightness::Number, alpha::Number }
toHsl color =
    case color of
      (HSLA h s l a) -> { hue:h, saturation:s, lightness:l, alpha:a }
      (RGBA r g b a) -> case rgbToHsl r g b of
        (Tuple h (Tuple s l)) -> { hue:h, saturation:s, lightness:l, alpha:a }

{-| Extract the components of a color in the RGB format.
-}
toRgb :: Color -> { red::Int, green::Int, blue::Int, alpha::Number }
toRgb color =
    case color of
      (RGBA r g b a) -> { red:r, green:g, blue:b, alpha:a }
      (HSLA h s l a) -> case hslToRgb h s l of
        (Tuple r (Tuple g b)) ->  { red   : round (255.0 * r)
                                  , green : round (255.0 * g)
                                  , blue  : round (255.0 * b)
                                  , alpha : a
                                  }

fmod :: Number -> Int -> Number
fmod f n =
  let integer = floor f
  in  toNumber (integer `mod` n) + f - toNumber integer

rgbToHsl :: Int -> Int -> Int -> (Tuple Number (Tuple Number Number))
rgbToHsl red green blue =
  let r = toNumber red   / 255.0
      g = toNumber green / 255.0
      b = toNumber blue  / 255.0

      cMax = max (max r g) b
      cMin = min (min r g) b

      c = cMax - cMin

      hue = (degrees 60.0) * case 0 of 0  | cMax == r -> ((g - b) / c) `fmod` 6
                                          | cMax == g -> ((b - r) / c) + 2.0
                                          | cMax == b -> ((r - g) / c) + 4.0

      lightness = (cMax + cMin) / 2.0

      saturation =
          if lightness == 0.0
            then 0.0
            else c / (1.0 - abs (2.0 * lightness - 1.0))
  in Tuple hue (Tuple saturation lightness)

hslToRgb :: Number -> Number -> Number -> (Tuple Number (Tuple Number Number))
hslToRgb hue saturation lightness =
  let chroma = (1.0 - abs (2.0 * lightness - 1.0)) * saturation
      hue' = hue / degrees 60.0

      x = chroma * (1.0 - abs (fmod hue' 2 - 1.0))

      rgb_ = case x of _  | hue' < 0.0 -> Tuple 0.0     (Tuple 0.0     0.0)
                          | hue' < 1.0 -> Tuple chroma  (Tuple x       0.0)
                          | hue' < 2.0 -> Tuple x       (Tuple chroma  0.0)
                          | hue' < 3.0 -> Tuple 0.0     (Tuple chroma  x)
                          | hue' < 4.0 -> Tuple 0.0     (Tuple x       chroma)
                          | hue' < 5.0 -> Tuple x       (Tuple 0.0     chroma)
                          | hue' < 6.0 -> Tuple chroma  (Tuple 0.0     x)
                          | otherwise  -> Tuple 0.0     (Tuple 0.0     0.0)

      m = lightness - chroma / 2.0
  in case rgb_ of (Tuple r (Tuple g b)) -> Tuple (r + m) (Tuple (g + m) (b + m))

--toV3 : Color -> V3

--toV4 : Color -> V4

data Gradient
  = Linear (Tuple Number Number) (Tuple Number Number) (Array (Tuple Number Color))
  | Radial (Tuple Number Number) Number (Tuple Number Number) Number (Array (Tuple Number Color))

{-| Create a linear gradient. Takes a start and end point and then a series of
&ldquo;color stops&rdquo; that indicate how to interpolate between the start and
end points. See [this example](http://elm-lang.org/edit/examples/Elements/LinearGradient.elm) for a
more visual explanation. -}
linear :: (Tuple Number Number) -> (Tuple Number Number) -> Array (Tuple Number Color) -> Gradient
linear = Linear

{-| Create a radial gradient. First takes a start point and inner radius.  Then
takes an end point and outer radius. It then takes a series of &ldquo;color
stops&rdquo; that indicate how to interpolate between the inner and outer
circles. See [this example](http://elm-lang.org/edit/examples/Elements/RadialGradient.elm) for a
more visual explanation. -}
radial :: (Tuple Number Number) -> Number -> (Tuple Number Number) -> Number -> Array (Tuple Number Color) -> Gradient
radial = Radial


-- BUILT-IN COLORS

lightRed    :: Color
lightRed    = RGBA 239 41 41 1.0
red    :: Color
red    = RGBA 204  0  0 1.0
darkRed    :: Color
darkRed    = RGBA 164  0  0 1.0

lightOrange :: Color
lightOrange = RGBA 252 175 62 1.0
orange :: Color
orange = RGBA 245 121  0 1.0
darkOrange :: Color
darkOrange = RGBA 206  92  0 1.0

lightYellow :: Color
lightYellow = RGBA 255 233 79 1.0
yellow :: Color
yellow = RGBA 237 212  0 1.0
darkYellow :: Color
darkYellow = RGBA 196 160  0 1.0

lightGreen  :: Color
lightGreen  = RGBA 138 226  52 1.0
green  :: Color
green  = RGBA 115 210  22 1.0
darkGreen :: Color
darkGreen  = RGBA  78 154   6 1.0

lightBlue   :: Color
lightBlue   = RGBA 114 159 207 1.0
blue   :: Color
blue   = RGBA  52 101 164 1.0
darkBlue   :: Color
darkBlue   = RGBA  32  74 135 1.0

lightPurple :: Color
lightPurple = RGBA 173 127 168 1.0
purple :: Color
purple = RGBA 117  80 123 1.0
darkPurple :: Color
darkPurple = RGBA  92  53 102 1.0

lightBrown  :: Color
lightBrown  = RGBA 233 185 110 1.0
brown  :: Color
brown  = RGBA 193 125  17 1.0
darkBrown  :: Color
darkBrown  = RGBA 143  89   2 1.0

black         :: Color
black         = RGBA  0   0   0  1.0
white         :: Color
white         = RGBA 255 255 255 1.0

lightGrey     :: Color
lightGrey     = RGBA 238 238 236 1.0
grey          :: Color
grey          = RGBA 211 215 207 1.0
darkGrey      :: Color
darkGrey      = RGBA 186 189 182 1.0

lightGray :: Color
lightGray = RGBA 238 238 236 1.0
gray      :: Color
gray      = RGBA 211 215 207 1.0
darkGray  :: Color
darkGray  = RGBA 186 189 182 1.0

lightCharcoal :: Color
lightCharcoal = RGBA 136 138 133 1.0
charcoal      :: Color
charcoal      = RGBA  85  87  83 1.0
darkCharcoal  :: Color
darkCharcoal  = RGBA  46  52  54 1.0
