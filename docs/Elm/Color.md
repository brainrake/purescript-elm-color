## Module Elm.Color

#### `Color`

``` purescript
data Color
  = RGBA Int Int Int Number
  | HSLA Number Number Number Number
```

##### Instances
``` purescript
instance showColor :: Show Color
```

#### `rgba`

``` purescript
rgba :: Int -> Int -> Int -> Number -> Color
```

#### `rgb`

``` purescript
rgb :: Int -> Int -> Int -> Color
```

Create RGB colors from numbers between 0 and 255 inclusive. 

#### `hsla`

``` purescript
hsla :: Number -> Number -> Number -> Number -> Color
```

#### `hsl`

``` purescript
hsl :: Number -> Number -> Number -> Color
```

#### `grayscale`

``` purescript
grayscale :: Number -> Color
```

Produce a gray based on the input. 0 is white, 1 is black. 

#### `greyscale`

``` purescript
greyscale :: Number -> Color
```

#### `complem`

``` purescript
complem :: Color -> Color
```

#### `toHsl`

``` purescript
toHsl :: Color -> { hue :: Number, saturation :: Number, lightness :: Number, alpha :: Number }
```

Extract the components of a color in the HSL format.

#### `toRgb`

``` purescript
toRgb :: Color -> { red :: Int, green :: Int, blue :: Int, alpha :: Number }
```

Extract the components of a color in the RGB format.

#### `Gradient`

``` purescript
data Gradient
  = Linear (Tuple Number Number) (Tuple Number Number) (Array (Tuple Number Color))
  | Radial (Tuple Number Number) Number (Tuple Number Number) Number (Array (Tuple Number Color))
```

#### `linear`

``` purescript
linear :: Tuple Number Number -> Tuple Number Number -> Array (Tuple Number Color) -> Gradient
```

#### `radial`

``` purescript
radial :: Tuple Number Number -> Number -> Tuple Number Number -> Number -> Array (Tuple Number Color) -> Gradient
```

#### `lightRed`

``` purescript
lightRed :: Color
```

#### `red`

``` purescript
red :: Color
```

#### `darkRed`

``` purescript
darkRed :: Color
```

#### `lightOrange`

``` purescript
lightOrange :: Color
```

#### `orange`

``` purescript
orange :: Color
```

#### `darkOrange`

``` purescript
darkOrange :: Color
```

#### `lightYellow`

``` purescript
lightYellow :: Color
```

#### `yellow`

``` purescript
yellow :: Color
```

#### `darkYellow`

``` purescript
darkYellow :: Color
```

#### `lightGreen`

``` purescript
lightGreen :: Color
```

#### `green`

``` purescript
green :: Color
```

#### `darkGreen`

``` purescript
darkGreen :: Color
```

#### `lightBlue`

``` purescript
lightBlue :: Color
```

#### `blue`

``` purescript
blue :: Color
```

#### `darkBlue`

``` purescript
darkBlue :: Color
```

#### `lightPurple`

``` purescript
lightPurple :: Color
```

#### `purple`

``` purescript
purple :: Color
```

#### `darkPurple`

``` purescript
darkPurple :: Color
```

#### `lightBrown`

``` purescript
lightBrown :: Color
```

#### `brown`

``` purescript
brown :: Color
```

#### `darkBrown`

``` purescript
darkBrown :: Color
```

#### `black`

``` purescript
black :: Color
```

#### `white`

``` purescript
white :: Color
```

#### `lightGrey`

``` purescript
lightGrey :: Color
```

#### `grey`

``` purescript
grey :: Color
```

#### `darkGrey`

``` purescript
darkGrey :: Color
```

#### `lightGray`

``` purescript
lightGray :: Color
```

#### `gray`

``` purescript
gray :: Color
```

#### `darkGray`

``` purescript
darkGray :: Color
```

#### `lightCharcoal`

``` purescript
lightCharcoal :: Color
```

#### `charcoal`

``` purescript
charcoal :: Color
```

#### `darkCharcoal`

``` purescript
darkCharcoal :: Color
```


