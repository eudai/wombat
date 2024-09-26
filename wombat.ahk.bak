#SingleInstance force
DetectHiddenWindows On
SetTitleMatchMode 2

Menu, Tray, Add, Unhide, UnhideWindow
Menu, Tray, Icon, C:\code\wombat\wombat.ico


Config=C:\code\wombat\wombat.ini

IniRead, Index, %Config%, Windows, Index, 0

::/hi::
send hello.
return

^!r::
reload:
::/reload::
Reload
return

#h::
HideWindow:
WinGetActiveTitle ActiveWindowTitle
Index ++
IniWrite %Index%, %Config%, HiddenWindows, Index
IniWrite %ActiveWindowTitle%, %Config%, HiddenWindows, %Index%
WinHide %ActiveWindowTitle%
return

#u::
UnhideWindow:
if (Index > 0)
{
	IniRead Title, %Config%, HiddenWindows, %Index%
	WinShow %Title%
	WinActivate %Title%
	IniDelete %Config%, HiddenWindows, %Index%
	Index --
	IniWrite %Index%, %Config%, HiddenWindows, Index
}
return


^#Numpad1 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 1
return

^#Numpad2 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 2
return

^#Numpad3 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 3
return

^#Numpad4 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 4
return

^#Numpad5 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 5
return

^#Numpad6 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 6
return

^#Numpad7 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 7
return

^#Numpad8 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 8
return

^#Numpad9 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 9
return

^#Numpad0 Up::
WinGetActiveTitle ActiveWindowTitle
IniWrite %ActiveWindowTitle%, %Config%, Windows, 0
return

#Numpad1 Up::
IniRead Title, %Config%, Windows, 1
WinShow %Title%
WinActivate %Title%
return

#Numpad2 Up::
IniRead Title, %Config%, Windows, 2
WinShow %Title%
WinActivate %Title%
return

#Numpad3 Up::
IniRead Title, %Config%, Windows, 3
WinShow %Title%
WinActivate %Title%
return

#Numpad4 Up::
IniRead Title, %Config%, Windows, 4
WinShow %Title%
WinActivate %Title%
return

#Numpad5 Up::
IniRead Title, %Config%, Windows, 5
WinShow %Title%
WinActivate %Title%
return

#Numpad6 Up::
IniRead Title, %Config%, Windows, 6
WinShow %Title%
WinActivate %Title%
return

#Numpad7 Up::
IniRead Title, %Config%, Windows, 7
WinShow %Title%
WinActivate %Title%
return

#Numpad8 Up::
IniRead Title, %Config%, Windows, 8
WinShow %Title%
WinActivate %Title%
return

#Numpad9 Up::
IniRead Title, %Config%, Windows, 9
WinShow %Title%
WinActivate %Title%
return

#Numpad0 Up::
IniRead Title, %Config%, Windows, 0
WinShow %Title%
WinActivate %Title%
return

Numpad1 Up::
Clipboard1 := clipboard
return

^Numpad2 Up::
Clipboard2 := clipboard
return

^Numpad3 Up::
Clipboard3 := clipboard
return

^Numpad4 Up::
Clipboard4 := clipboard
return

^Numpad5 Up::
Clipboard5 := clipboard
return

^Numpad6 Up::
Clipboard6 := clipboard
return

^Numpad7 Up::
Clipboard7 := clipboard
return

^Numpad8 Up::
Clipboard8 := clipboard
return

^Numpad9 Up::
Clipboard9 := clipboard
return

^Numpad0 Up::
Clipboard0 := clipboard
return

!Numpad1 Up::
clipboard := Clipboard1
return

!Numpad2 Up::
clipboard := Clipboard2
return

!Numpad3 Up::
clipboard := Clipboard3
return

!Numpad4 Up::
clipboard := Clipboard4
return

!Numpad5 Up::
clipboard := Clipboard5
return

!Numpad6 Up::
clipboard := Clipboard6
return

!Numpad7 Up::
clipboard := Clipboard7
return

!Numpad8 Up::
clipboard := Clipboard8
return

!Numpad9 Up::
clipboard := Clipboard9
return

!Numpad0 Up::
clipboard := Clipboard0
return