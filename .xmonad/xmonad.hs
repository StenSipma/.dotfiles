-- Import Statements
import XMonad

-- Config
import XMonad.Config.Desktop

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition

-- Layout
import XMonad.ManageHook
import qualified XMonad.StackSet as W

-- Util
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.EZConfig (additionalKeys)

import System.IO

-- Import Media Keys
import Graphics.X11.ExtraTypes.XF86


-- Colours
myBackgroundColour      = "#2f343f"
myLightBackgroundColour = "#69748C"
-- text
myTextColour            = "#f3f4f5"
myAlternateTextColour   = "#C8CDDE"
myFocusedTextColour     = myTextColour
myInactiveTextColour    = "#676E7D"
-- border
myNormalBorderColor     = "#666666"
myFocusedBorderColor    = "#DEDEDE"

-- Variables
--myTerminal           = "st"
myTerminal           = "kitty"
myModMask            = mod4Mask
myBorderWidth        = 2

-- Keybindings
myKeys' :: [((KeyMask, KeySym), X ())]
myKeys' = 
        -- Application starter (rofi)
    [ ((myModMask, xK_d), spawn "rofi -show drun -modi drun#run -show-icons -theme Arc-Dark-Custom")

    -- Control volume of currently selected sink
    , ((noModMask, xF86XK_AudioRaiseVolume), spawn "volume up")
    , ((noModMask, xF86XK_AudioLowerVolume), spawn "volume down")
    , ((noModMask, xF86XK_AudioMute), spawn "volume mute")

    -- Control (laptop) brightness 
    , ((noModMask, xF86XK_MonBrightnessUp), spawn "brightness up")
    , ((noModMask, xF86XK_MonBrightnessDown), spawn "brightness down")

    -- Binding Play/Pause, Next, Previous buttons to playerctl (e.g. control spotify)
    , ((noModMask, xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((noModMask, xF86XK_AudioNext), spawn "playerctl next")
    , ((noModMask, xF86XK_AudioPrev), spawn "playerctl previous")

    , ((noModMask, xK_Print), spawn "flameshot gui")
    ]

-- PrettyPrinter format specification for sending info to the status bar (xmobar)
-- `proc` argument is needed to specify where to data is being sent to
myPP proc = xmobarPP 
    { ppOutput = hPutStrLn proc
    , ppSep = "    " 

    , ppCurrent = xmobarColor myBackgroundColour myTextColour . pad
    , ppVisible = xmobarColor myTextColour myLightBackgroundColour . pad
    , ppHidden = pad 

    , ppLayout = wrap "Layout: " "" . xmobarColor myAlternateTextColour ""
    , ppTitle = wrap "Window:  " "" . xmobarColor myAlternateTextColour "" . shorten 100
    }

-- Usefull function to create action statements
wrapAction :: String -> String -> String
wrapAction a body = "<action=" ++ a ++ ">" ++ body ++ "</action>"

-- Enumerate function, adds indexes starting at some integer 
-- enum 0 ["a", "b", "c"]
-- --> [(0, "a"), (1, "b"), (2, "c")]
enum :: Integral i => i -> [a] -> [(i, a)]
enum n = zip [n..]

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
      where 
        doubleLts '<' = "<<"
        doubleLts x   = [x]

-- Workspaces (clickable)
-- requires `xdotool` and usage of UnsafeStdInReader
workspacesList :: [String]
workspacesList = [ "Main" , "Browser" , "Terminal" , "Editor" , "5" , "Video" , "7" , "Email" , "Music" ]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ workspacesList
               where clickable xs = [wrapAction ("xdotool key super+" ++ show n) ws | (n,  ws) <- enum 1 xs ]

-- Assign Applications to workspaces when started
myManageHook = composeAll [ (className =? "firefox") <&&> (stringProperty "WM_WINDOW_ROLE" =? "browser")
                                                       --> doShift (myWorkspaces!!1)
                          , className =? "Emacs"       --> doShift (myWorkspaces!!3)
                          , className =? "Thunderbird" --> doShift (myWorkspaces!!7)
                          -- Match Spotify, no classname given on startup!
                          , className =? ""            --> doShift (myWorkspaces!!8)
                          , className =? "Peek"        --> doFloat
              ]

myStartupHook :: X ()
myStartupHook = do  -- Start the wallpaper manager using the previous config
                    spawnOnce "nitrogen --restore &"
                    -- Start a system tray for some applications (e.g. NetworkManager)
                    -- Options:
                    -- geometry: [widthxheight]+x+y
                    --           width and height are the default size for icon 
                    --           +x is shift right by x (pixels?), opposite for -x (will wrap around)
                    -- background: colour
                    -- grow-gravity: direction for the bar to grow into, [N, W, S, E] or any 
                    --               combination of them (i.e NE, to grow right and bottom)
                    spawnOnce "stalonetray --geometry 6x1+1330+2 --icon-gravity NE --grow-gravity NW --background \"#2f343f\" &"
                    -- Start the tray applet for NetworkManager. Might error if using wicd ?
                    spawnOnce "nm-applet &"
                    -- Start the tray applet for Pulseaudio control
                    spawnOnce "pasystray &"
                    -- Start Rocket.Chat app. Note; you have to 'enable' the tray icon
                    -- By clicking: View --> Tray Icon
                    spawnOnce "rocketchat-desktop &"

-- Main xmobar run sequence
main = do
        -- Start the status bar using the specified config.
        -- The result of the spawned process is given to the log pretty printer (PP)
        xmproc <- spawnPipe "xmobar $XDG_CONFIG_HOME/xmobar/xmobarrc"
        xmonad $ desktopConfig
                -- Dictionary with custom values and hooks
                    -- manageDocks     will shift the screen so the statusbar is visible
                -- insertPosition  determines where a new window is spawned on the page.
                { manageHook  = manageDocks <+> insertPosition End Newer <+> myManageHook <+> manageHook def
                , layoutHook  = avoidStruts  $ layoutHook def
                , logHook     = dynamicLogWithPP $ myPP xmproc
                , startupHook = myStartupHook
                , workspaces  = myWorkspaces
                , terminal           = myTerminal
                , modMask            = myModMask
                , borderWidth        = myBorderWidth
                , normalBorderColor  = myNormalBorderColor
                , focusedBorderColor = myFocusedBorderColor
                }
            -- Apply additional custom keys
            `additionalKeys` myKeys'

