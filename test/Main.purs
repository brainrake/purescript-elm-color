module Test.Main where

import Prelude (show)
import Elm.Basics ((<|))
import Elm.Color (darkCharcoal, complem)
import Control.Monad.Eff.Console (log)

main = do
  log <| show <| complem <| darkCharcoal
