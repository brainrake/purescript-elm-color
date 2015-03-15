# Module Documentation

## Module Elm.Color

#### `Color`

``` purescript
data Color
  = RGBA Int Int Int Float
  | HSLA Float Float Float Float
```


#### `showColor`

``` purescript
instance showColor :: Show Color
```


#### `rgba`

``` purescript
rgba :: Int -> Int -> Int -> Float -> Color
```

#### `rgb`

``` purescript
rgb :: Int -> Int -> Int -> Color
```

Create RGB colors from numbers between 0 and 255 inclusive. 

#### `hsla`

``` purescript
hsla :: Float -> Float -> Float -> Float -> Color
```

#### `hsl`

``` purescript
hsl :: Float -> Float -> Float -> Color
```

#### `grayscale`

``` purescript
grayscale :: Float -> Color
```

Produce a gray based on the input. 0 is white, 1 is black. 

#### `greyscale`

``` purescript
greyscale :: Float -> Color
```


#### `complem`

``` purescript
complem :: Color -> Color
```

#### `toHsl`

``` purescript
toHsl :: Color -> { alpha :: Float, lightness :: Float, saturation :: Float, hue :: Float }
```

Extract the components of a color in the HSL format.

#### `toRgb`

``` purescript
toRgb :: Color -> { alpha :: Float, blue :: Int, green :: Int, red :: Int }
```

Extract the components of a color in the RGB format.

#### `Gradient`

``` purescript
data Gradient
  = Linear (Tuple Float Float) (Tuple Float Float) [Tuple Float Color]
  | Radial (Tuple Float Float) Float (Tuple Float Float) Float [Tuple Float Color]
```

#### `linear`

``` purescript
linear :: Tuple Number Number -> Tuple Number Number -> [Tuple Float Color] -> Gradient
```

#### `radial`

``` purescript
radial :: Tuple Number Number -> Number -> Tuple Number Number -> Number -> [Tuple Float Color] -> Gradient
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




