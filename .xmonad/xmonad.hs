import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run

main :: IO()
main = do
  myStatusBar <- spawnPipe "xmobar"
  xmonad $ defaultConfig
    { terminal = "mlterm"
    , modMask = mod4Mask
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , logHook = myLogHook myStatusBar
    }

myLayoutHook = avoidStruts $ layoutHook defaultConfig
myManageHook = manageDocks <+> manageHook defaultConfig

myLogHook h = dynamicLogWithPP xmobarPP {
                ppOutput = hPutStrLn h
              }



