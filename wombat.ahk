#SingleInstance force
DetectHiddenWindows On
SetTitleMatchMode 2

Menu, Tray, Add, Unhide, UnhideWindow
Menu, Tray, Icon, C:\code\wombat\wombat.ico

Config=C:\code\wombat\wombat.ini

IniRead, Index, %Config%, Windows, Index, 0


Hotkey, ^!r, Restart, On

Hotkey, #h, HideWindow, On
Hotkey, #u, UnHideWindow, On

Hotkey, ^!t, MountWindow, Off

Hotkey, ^!WheelDown, WinFade, On
Hotkey, ^!WheelUp, WinUnFade, On

Hotkey, #^!LButton, AutoClick, On
Hotkey, #Escape, StopAutoClick, On

Hotkey, ^!Enter, ToggleClickHold, On

Hotkey, ^!Up, NudgeUp, On
Hotkey, ^!Down, NudgeDown, On
Hotkey, ^!Left, NudgeLeft, On
Hotkey, ^!Right, NudgeRight, On

Hotkey, ^#Numpad1, SaveWindow1, On
Hotkey, ^#Numpad2, SaveWindow2, On
Hotkey, ^#Numpad3, SaveWindow3, On
Hotkey, ^#Numpad4, SaveWindow4, On
Hotkey, ^#Numpad5, SaveWindow5, On
Hotkey, ^#Numpad6, SaveWindow6, On
Hotkey, ^#Numpad7, SaveWindow7, On
Hotkey, ^#Numpad8, SaveWindow8, On
Hotkey, ^#Numpad9, SaveWindow9, On
Hotkey, ^#Numpad0, SaveWindow0, On

Hotkey, #Numpad1, ActivateWindow1, On
Hotkey, #Numpad2, ActivateWindow2, On
Hotkey, #Numpad3, ActivateWindow3, On
Hotkey, #Numpad4, ActivateWindow4, On
Hotkey, #Numpad5, ActivateWindow5, On
Hotkey, #Numpad6, ActivateWindow6, On
Hotkey, #Numpad7, ActivateWindow7, On
Hotkey, #Numpad8, ActivateWindow8, On
Hotkey, #Numpad9, ActivateWindow9, On
Hotkey, #Numpad0, ActivateWindow0, On

Hotkey, ^!#Numpad1, SavePosition1, On
Hotkey, ^!#Numpad2, SavePosition2, On
Hotkey, ^!#Numpad3, SavePosition3, On
Hotkey, ^!#Numpad4, SavePosition4, On
Hotkey, ^!#Numpad5, SavePosition5, On
hotkey, ^!#Numpad6, SavePosition6, On
Hotkey, ^!#Numpad7, SavePosition7, On
Hotkey, ^!#Numpad8, SavePosition8, On
Hotkey, ^!#Numpad9, SavePosition9, On
Hotkey, ^!#Numpad0, SavePosition0, On

Hotkey, !#Numpad1, LoadPosition1, On
Hotkey, !#Numpad2, LoadPosition2, On
Hotkey, !#Numpad3, LoadPosition3, On
Hotkey, !#Numpad4, LoadPosition4, On
Hotkey, !#Numpad5, LoadPosition5, On
Hotkey, !#Numpad6, LoadPosition6, On
Hotkey, !#Numpad7, LoadPosition7, On
Hotkey, !#Numpad8, LoadPosition8, On
Hotkey, !#Numpad9, LoadPosition9, On
Hotkey, !#Numpad0, LoadPosition0, On

Hotkey, ^Numpad1, SaveClipboard1, On
Hotkey, ^Numpad2, SaveClipboard2, On
Hotkey, ^Numpad3, SaveClipboard3, On
Hotkey, ^Numpad4, SaveClipboard4, On
Hotkey, ^Numpad5, SaveClipboard5, On
Hotkey, ^Numpad6, SaveClipboard6, On
Hotkey, ^Numpad7, SaveClipboard7, On
Hotkey, ^Numpad8, SaveClipboard8, On
Hotkey, ^Numpad9, SaveClipboard9, On
Hotkey, ^Numpad0, SaveClipboard0, On

Hotkey, !Numpad1, LoadClipboard1, On
Hotkey, !Numpad2, LoadClipboard2, On
Hotkey, !Numpad3, LoadClipboard3, On
Hotkey, !Numpad4, LoadClipboard4, On
Hotkey, !Numpad5, LoadClipboard5, On
Hotkey, !Numpad6, LoadClipboard6, On
Hotkey, !Numpad7, LoadClipboard7, On
Hotkey, !Numpad8, LoadClipboard8, On
Hotkey, !Numpad9, LoadClipboard9, On
Hotkey, !Numpad0, LoadClipboard0, On

GoSub Greeting

return

Greeting:
ToolTip Hello.
SetTimer, RemoveToolTip, 1000
return

RemoveToolTip:
ToolTip
return

MountWindow:
WinSet, AlwaysOnTop, Toggle, A
return

WinFade:
WinGet, Transparency, Transparent, A
if Transparency is not integer
	Transparency = 255
NewTransparency := Transparency - 1
if NewTransparency < 50
	return
WinSet, Transparent, %NewTransparency%, A
return

WinUnFade:
WinGet, Transparency, Transparent, A
if Transparency is not integer
	Transparency = 255
if NewTransparency >= 255
	return
NewTransparency := Transparency + 1
WinSet, Transparent, %NewTransparency%, A
return

AutoClick:
MouseGetPos, X1, Y1,
WinGetActiveTitle TargetWindow
InputBox Interval, Wombat, Set Interval.
Loop {
	Sleep %Interval%
	MouseGetPos X2, Y2
	WinGetActiveTitle ActiveWindow
	WinActivate %TargetWindow%
	Click %X1%, %Y1%
	WinActivate %ActiveWindow%
	MouseMove %X2%, %Y2%
} Until EscapeWasPressed
EscapeWasPressed := 0
return

StopAutoClick:
EscapeWasPressed := 1
return

ToggleClickHold:
state := GetKeyState("LButton")
if state
{
	Click Up
} else {
	Click Down
}
return

NudgeUp:
MouseMove 0, -1, 0, R
return

NudgeDown:
MouseMove 0, 1, 0, R
return

NudgeLeft:
MouseMove -1, 0, 0, R
return

NudgeRight:
MouseMove 1, 0, 0, R
return

HideWindow:
WinGet ActiveWindowId, ID, A
Index ++
IniWrite %Index%, %Config%, HiddenWindows, Index
IniWrite %ActiveWindowId%, %Config%, HiddenWindows, %Index%
WinHide ahk_id %ActiveWindowId%
return

UnhideWindow:
if (Index > 0)
{
	IniRead WindowId, %Config%, HiddenWindows, %Index%
	WinShow ahk_id %WindowId%
	WinActivate %Title%
	IniDelete %Config%, HiddenWindows, %Index%
	Index --
	IniWrite %Index%, %Config%, HiddenWindows, Index
}
return

SaveWindow1:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 1
return

SaveWindow2:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 2
return

SaveWindow3:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 3
return

SaveWindow4:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 4
return

SaveWindow5:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 5
return

SaveWindow6:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 6
return

SaveWindow7:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 7
return

SaveWindow8:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 8
return

SaveWindow9:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 9
return

SaveWindow0:
WinGet ActiveWindowId, ID, A
IniWrite %ActiveWindowId%, %Config%, Windows, 0
return

ActivateWindow1:
IniRead Title, %Config%, Windows, 1
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow2:
IniRead Title, %Config%, Windows, 2
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow3:
IniRead Title, %Config%, Windows, 3
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow4:
IniRead Title, %Config%, Windows, 4
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow5:
IniRead Title, %Config%, Windows, 5
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow6:
IniRead Title, %Config%, Windows, 6
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow7:
IniRead Title, %Config%, Windows, 7
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow8:
IniRead Title, %Config%, Windows, 8
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow9:
IniRead Title, %Config%, Windows, 9
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

ActivateWindow0:
IniRead Title, %Config%, Windows, 0
WinShow ahk_id %Title%
WinActivate ahk_id %Title%
return

SaveClipboard1:
Clipboard1 := clipboard
return

SaveClipboard2:
Clipboard2 := clipboard
return

SaveClipboard3:
Clipboard3 := clipboard
return

SaveClipboard4:
Clipboard4 := clipboard
return

SaveClipboard5:
Clipboard5 := clipboard
return

SaveClipboard6:
Clipboard6 := clipboard
return

SaveClipboard7:
Clipboard7 := clipboard
return

SaveClipboard8:
Clipboard8 := clipboard
return

SaveClipboard9:
Clipboard9 := clipboard
return

SaveClipboard0:
Clipboard0 := clipboard
return

LoadClipboard1:
clipboard := Clipboard1
return

LoadClipboard2:
clipboard := Clipboard2
return

LoadClipboard3:
clipboard := Clipboard3
return

LoadClipboard4:
clipboard := Clipboard4
return

LoadClipboard5:
clipboard := Clipboard5
return

LoadClipboard6:
clipboard := Clipboard6
return

LoadClipboard7:
clipboard := Clipboard7
return

LoadClipboard8:
clipboard := Clipboard8
return

LoadClipboard9:
clipboard := Clipboard9
return

LoadClipboard0:
clipboard := Clipboard0
return


SavePosition1:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_1, X
IniWrite %Y%, %Config%, WindowPosition_1, Y
IniWrite %W%, %Config%, WindowPosition_1, W
IniWrite %H%, %Config%, WindowPosition_1, H
return

SavePosition2:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_2, X
IniWrite %Y%, %Config%, WindowPosition_2, Y
IniWrite %W%, %Config%, WindowPosition_2, W
IniWrite %H%, %Config%, WindowPosition_2, H
return

SavePosition3:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_3, X
IniWrite %Y%, %Config%, WindowPosition_3, Y
IniWrite %W%, %Config%, WindowPosition_3, W
IniWrite %H%, %Config%, WindowPosition_3, H
return

SavePosition4:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_4, X
IniWrite %Y%, %Config%, WindowPosition_4, Y
IniWrite %W%, %Config%, WindowPosition_4, W
IniWrite %H%, %Config%, WindowPosition_4, H
return

SavePosition5:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_5, X
IniWrite %Y%, %Config%, WindowPosition_5, Y
IniWrite %W%, %Config%, WindowPosition_5, W
IniWrite %H%, %Config%, WindowPosition_5, H
return

SavePosition6:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_6, X
IniWrite %Y%, %Config%, WindowPosition_6, Y
IniWrite %W%, %Config%, WindowPosition_6, W
IniWrite %H%, %Config%, WindowPosition_6, H
return

SavePosition7:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_7, X
IniWrite %Y%, %Config%, WindowPosition_7, Y
IniWrite %W%, %Config%, WindowPosition_7, W
IniWrite %H%, %Config%, WindowPosition_7, H
return

SavePosition8:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_8, X
IniWrite %Y%, %Config%, WindowPosition_8, Y
IniWrite %W%, %Config%, WindowPosition_8, W
IniWrite %H%, %Config%, WindowPosition_8, H
return

SavePosition9:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_9, X
IniWrite %Y%, %Config%, WindowPosition_9, Y
IniWrite %W%, %Config%, WindowPosition_9, W
IniWrite %H%, %Config%, WindowPosition_9, H
return

SavePosition0:
WinGetActiveStats Title, W, H, X, Y
IniWrite %X%, %Config%, WindowPosition_0, X
IniWrite %Y%, %Config%, WindowPosition_0, Y
IniWrite %W%, %Config%, WindowPosition_0, W
IniWrite %H%, %Config%, WindowPosition_0, H
return

LoadPosition1:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_1, X
IniRead Y, %Config%, WindowPosition_1, Y
IniRead W, %Config%, WindowPosition_1, W
IniRead H, %Config%, WindowPosition_1, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition2:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_2, X
IniRead Y, %Config%, WindowPosition_2, Y
IniRead W, %Config%, WindowPosition_2, W
IniRead H, %Config%, WindowPosition_2, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition3:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_3, X
IniRead Y, %Config%, WindowPosition_3, Y
IniRead W, %Config%, WindowPosition_3, W
IniRead H, %Config%, WindowPosition_3, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition4:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_4, X
IniRead Y, %Config%, WindowPosition_4, Y
IniRead W, %Config%, WindowPosition_4, W
IniRead H, %Config%, WindowPosition_4, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition5:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_5, X
IniRead Y, %Config%, WindowPosition_5, Y
IniRead W, %Config%, WindowPosition_5, W
IniRead H, %Config%, WindowPosition_5, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition6:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_6, X
IniRead Y, %Config%, WindowPosition_6, Y
IniRead W, %Config%, WindowPosition_6, W
IniRead H, %Config%, WindowPosition_6, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition7:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_7, X
IniRead Y, %Config%, WindowPosition_7, Y
IniRead W, %Config%, WindowPosition_7, W
IniRead H, %Config%, WindowPosition_7, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition8:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_8, X
IniRead Y, %Config%, WindowPosition_8, Y
IniRead W, %Config%, WindowPosition_8, W
IniRead H, %Config%, WindowPosition_8, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition9:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_9, X
IniRead Y, %Config%, WindowPosition_9, Y
IniRead W, %Config%, WindowPosition_9, W
IniRead H, %Config%, WindowPosition_9, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

LoadPosition0:
WinGetActiveTitle WinTitle
IniRead X, %Config%, WindowPosition_0, X
IniRead Y, %Config%, WindowPosition_0, Y
IniRead W, %Config%, WindowPosition_0, W
IniRead H, %Config%, WindowPosition_0, H
WinMove, %WinTitle%, , %X%, %Y%, %W%, %H%
return

Restart:
Reload
return