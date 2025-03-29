-- Import Statements
import XMonad

-- Config
import XMonad.Config.Desktop

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers

-- Layout
import XMonad.ManageHook
import qualified XMonad.StackSet as W

-- Util
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)
import XMonad.Util.EZConfig (additionalKeys)

import System.IO
import Data.Char

-- Import Media Keys
import Graphics.X11.ExtraTypes.XF86

---------------
-- Constants --
---------------

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
myTerminal           = "kitty --listen-on=unix:@\"$(date +%s%N)\""
myModMask            = mod4Mask
myBorderWidth        = 2

-------------------------------
-- General Utility Functions --
-------------------------------

-- Enumerate function, adds indexes starting at some integer
-- enum 0 ["a", "b", "c"]
-- --> [(0, "a"), (1, "b"), (2, "c")]
enum :: Integral i => i -> [a] -> [(i, a)]
enum n = zip [n..]

-- Removes whitespace at the end and beginning of the string:
-- strip " value\n"
-- --> "value"
-- strip " \n value with spaced \n and\n newlines\n"
-- strip "value with spaced \n and\n newlines"
strip :: String -> String
strip = reverse . dropWhile (isSpace) . reverse . dropWhile isSpace

-- Converts a string to lowercase
-- lower "AbC DEFg"
-- --> "abc defg"
-- lower "already lowercase"
-- --> "already lowercase"
lower :: String -> String
lower = map toLower

------------
-- Config --
------------

-- Keybindings
myKeys' :: [((KeyMask, KeySym), X ())]
myKeys' =
        -- Application starter (rofi)
    -- [ ((myModMask, xK_d), spawn "rofi -show drun -modi drun#run -show-icons -theme Arc-Dark-Custom")
    [ ((myModMask, xK_d), spawn "rofi -show drun -modi drun#run")

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
    , ppTitle  = wrap "Window: " "" . xmobarColor myAlternateTextColour "" . shorten 50
    }


-- Usefull function to create action statements
wrapAction :: String -> String -> String
wrapAction a body = "<action=" ++ a ++ ">" ++ body ++ "</action>"


xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
      where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

-- Workspaces (clickable)
-- requires `xdotool` and usage of UnsafeStdInReader
workspacesList :: [String]
workspacesList = [ "Main" , "\62057  Browser" , "\62601  Terminal" , "\61508 "  , "5" , "\63608 " , "7" , "\63213 " , "\61884 " ]
--                  Main  ,                 ,                  ,   Editor ,     ,  Video  ,     ,  Email  , \61441 \61884 Music

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ workspacesList
               where clickable xs = [wrapAction ("xdotool key super+" ++ show n) ws | (n,  ws) <- enum 1 xs ]

-- Assign Applications to workspaces when started
-- use `xprop` to find these names.
myManageHook = composeAll [ (classNameLower =? "firefox") <&&> (stringProperty "WM_WINDOW_ROLE" =? "browser")
                                                       --> doShift (myWorkspaces!!1)
                          , classNameLower =? "emacs"       --> doShift (myWorkspaces!!3)
                          , classNameLower =? "mattermost"  --> doShift (myWorkspaces!!5)
                          , classNameLower =? "thunderbird" --> doShift (myWorkspaces!!7)
                          -- Match Spotify, no classname given on startup!
                          , classNameLower =? ""            --> doShift (myWorkspaces!!8)
                          , classNameLower =? "peek"        --> doFloat

              ]
              -- Converts the classname to lowercase
              where classNameLower = lower <$> className

-- Managed difference between dialog (intended floating) and 'normal' windows
-- When a window is a dialog:
--     a new spawn should appear in front, and be focused
-- Otherwise:
--     the window should spawn at the end of the stack (i.e. at the right) and
--     still be in focus.
myFocusManager = composeOne [ isDialog   -?> insertPosition Above Newer
                            , qOtherwise -?> insertPosition End Newer
                            ]
                where qOtherwise = return otherwise -- We raise the Bool to Query Bool with this

myStartupHook :: X ()
myStartupHook = do  -- Start the wallpaper manager using the previous config
                    spawnOnce "nitrogen --restore &"
                    -- Start the compositor, allowing transparent windows
                    -- Options:
                    --   - fade-delta: time (milliseconds) between fade steps (i.e. when
                    --                 switching/opening windows etc.)
                    --   - menu-opacity: Opacity of dropdown menu's (1.0 = no see through)
                    spawnOnce "picom --fade-delta 5 --menu-opacity=1.0 &"
                    -- Start a system tray for some applications (e.g. NetworkManager)
                    -- Options:
                    -- geometry: [widthxheight]+x+y
                    --           width and height are the default size for icon
                    --           +x is shift right by x (pixels?), opposite for -x (will wrap around)
                    -- background: colour
                    -- grow-gravity: direction for the bar to grow into, [N, W, S, E] or any
                    --               combination of them (i.e NE, to grow right and bottom)
                    spawnOnce "stalonetray --geometry 6x1+1000 --icon-gravity NE --grow-gravity NW --background \"#2f343f\" &"
                    -- Start the tray applet for NetworkManager. Might error if using wicd ?
                    spawnOnce "nm-applet &"
                    -- Start the tray applet for Pulseaudio control
                    spawnOnce "pasystray &"
                    -- Start Rocket.Chat app. Note; you have to 'enable' the tray icon
                    -- By clicking: View --> Tray Icon
                    -- spawnOnce "rocketchat-desktop &"
                    -- Start nextcloud sync
                    spawnOnce "nextcloud --background &"

runXmobar "EXOSAT" = spawnPipe "xmobar $XDG_CONFIG_HOME/xmobar/EXOSAT.xmobarrc"
runXmobar "Auriga" = spawnPipe "xmobar $XDG_CONFIG_HOME/xmobar/xmobarrc"
runXmobar _        = spawnPipe "xmobar $XDG_CONFIG_HOME/xmobar/xmobarrc"

-- Main xmobar run sequence
main = do
        -- Start the status bar using the specified config.
        -- The result of the spawned process is given to the log pretty printer (PP)
        hostname <- readFile "/etc/hostname"
        xmproc <- runXmobar $ strip hostname
        xmonad $ desktopConfig
                -- Dictionary with custom values and hooks
                    -- manageDocks     will shift the screen so the statusbar is visible
                -- insertPosition  determines where a new window is spawned on the page.
                -- { manageHook  = manageDocks <+> insertPosition Master Newer <+> myManageHook <+> manageHook def
                { manageHook  = manageDocks <+> myFocusManager <+> myManageHook <+> manageHook def
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

