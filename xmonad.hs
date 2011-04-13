import XMonad
import qualified XMonad.StackSet as W

import XMonad.Config.Gnome
import XMonad.Util.EZConfig
import XMonad.ManageHook
import XMonad.Actions.CycleWS
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders

myManageHook :: [ManageHook]
myManageHook =
	[ resource  =? "Do" --> doIgnore,
  , isFullscreen --> doFullFloat ]

main = xmonad $ gnomeConfig
	{ modMask = mod4Mask
        , terminal = "urxvt"
        , borderWidth = 2
       	, manageHook = manageHook gnomeConfig <+> composeAll myManageHook
	      , logHook = ewmhDesktopsLogHook >> setWMName "LG3D" -- java workaround
        , layoutHook = smartBorders $ layoutHook gnomeConfig
	}
	`additionalKeysP`
		[ ("M-S-q", spawn "gnome-session-save --gui --logout-dialog") -- display logout-dialog
		-- Lock Screen
		, ("M-S-l", spawn "gnome-screensaver-command -l")
		, ("M-p", spawn "kupfer")
		, ("M-<Space>", spawn "kupfer")
		, ("<XF86Forward>", nextWS)
		, ("<XF86Back>", prevWS)
		, ("M1-<Tab>", windows W.focusDown)
		, ("M-<R>", nextScreen)
		, ("M-<L>", prevScreen)
		]
