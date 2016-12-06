import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig
import Data.Maybe (fromJust)
import Data.List (elemIndex)
import Graphics.X11.ExtraTypes.XF86;
import System.IO

-- Unmasked KeySym
unKey k x = ((noModMask, k), x)

spaces = ["gen", "web", "eml", "gen", "cht", "ext", "ext", "ext", "ext"]
spaceIdxs = map show [1..(length spaces)]

spaceMap :: [(String, String)]
spaceMap = zip spaceIdxs spaces

spaceName :: String -> String
spaceName spIdx = fromJust $ lookup spIdx spaceMap

spaceFmt :: (String -> String) -> String -> String
spaceFmt f spIdx = (f $ spaceName spIdx) ++ "/" ++ spIdx 

logPP xmobar = defaultPP { 
                           ppCurrent = spaceFmt (xmobarColor "black" "grey")
                         , ppHidden = (\sp -> "/" ++ xmobarColor "orange" "" sp)
                         , ppHiddenNoWindows = \sp -> "/" ++ sp
                         , ppUrgent = (\x -> "URG!") . xmobarStrip -- spaceFmt (xmobarColor "white" "red")
                         , ppOrder = \[ws,layout,title] -> [ws]
                         , ppOutput = hPutStrLn xmobar
                         }

main = do 
    xmobar_pipe <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
      layoutHook = avoidStruts $ layoutHook defaultConfig
    , logHook = dynamicLogWithPP $ logPP xmobar_pipe 
    , workspaces = spaceIdxs 
    , terminal = "urxvt"
    } `additionalKeys` [ 
        unKey xF86XK_AudioPlay $ spawn "mpc toggle"
      , ((mod1Mask, xK_c), spawn "mpc toggle")
      , unKey xF86XK_AudioStop $ spawn "mpc stop"
      , unKey xF86XK_AudioPrev $ spawn "mpc prev"
      , ((mod1Mask, xK_z), spawn "mpc prev")
      , unKey xF86XK_AudioNext $ spawn "mpc next"
      , ((mod1Mask, xK_v), spawn "mpc next")
      , unKey xF86XK_AudioLowerVolume $ spawn "amixer set Master 2dB-"
      , unKey xF86XK_AudioRaiseVolume $ spawn "amixer set Master 2dB+"
      , unKey xF86XK_ScreenSaver $ spawn "slock"
      , ((mod1Mask, xK_b), sendMessage ToggleStruts)
      ]
