import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import System.IO

main = do
    xmonad $ defaultConfig {
        layoutHook = avoidStruts $ layoutHook defaultConfig
    }
