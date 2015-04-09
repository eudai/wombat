

Prologue:
{
	#SingleInstance Force
	TrayTip,,Loading...
	FileCreateDir %AppData%\Wombat
	SetWorkingDir %AppData%\Wombat
	IfNotExist Encyclopedia.ini
		gosub Default_Encyclopedia
	Load_Menus("Encyclopedia.ini","Menus")
	Load_Hotkeys("Encyclopedia.ini","Hotkeys")
	OnExit UnhideAllThenExit
	SetTitleMatchMode 2
	TrayTip,, Wombat loaded.
	Sleep 1000
	TrayTip
	return
}

Encyclopedia:
{
	IfWinExist Encyclopedia.ini - Notepad
		WinActivate
	else
		Run Notepad.exe Encyclopedia.ini
	return
}

Default_Encyclopedia:
{
	TrayTip, No encyclopedia detected. Default encyclopedia written.
	IniWrite www.google.com, Encyclopedia.ini, Dictionary, google
	IniWrite SaveClipboard, Encyclopedia.ini, Hotkeys, ~^c
	IniWrite Hotstring, Encyclopedia.ini, Hotkeys, ~/
	IniWrite Box, Encyclopedia.ini, Hotkeys, ^enter
	IniWrite WinHide, Encyclopedia.ini, Hotkeys, #H
	IniWrite UnHide, Encyclopedia.ini, Hotkeys, #U
	IniWrite Icon, Encyclopedia.ini, Hotkeys, #F10
	IniWrite Reload, Encyclopedia.ini, Hotkeys, #F11
	IniWrite Exit, Encyclopedia.ini, Hotkeys, #F12
	IniWrite Encyclopedia, Encyclopedia.ini, Menus, Tray\Encyclopedia
	IniWrite % A_Space, Encyclopedia.ini, Menus, Tray\
	IniWrite Reload, Encyclopedia.ini, Menus, Tray\Reload
	IniWrite Exit, Encyclopedia.ini, Menus, Tray\Exit
	return
}

Box:
{
	Word := Box()
	IniRead Definition, Encyclopedia.ini, Dictionary, % Word, % A_Space
	if ErrorLevel
		return
	if Definition
	{
		if IsLabel(Definition)
			goto % Definition
		run % Definition,, UseErrorLevel
	}
	else
	{
		if IsLabel(Word)
			goto % Word
		else
			Run % Word,, UseErrorLevel
	}
	return
}

Hotstring:
{
	Input Word, v*i, `n `t
	if Word =
		return
	IniRead, Definition, Encyclopedia.ini, Dictionary, % Word, % A_Space
	if Definition =
		return
	StringLen Length, Word
	Loop % Length + 2
		SendInput {backspace}
	if IsLabel(Definition)
		goto % Definition
	Run % Definition,, UseErrorLevel
	if ErrorLevel
		SendInput % Definition
	return
}

Sendstring:
{
	Input Word, v*i, `n `t
	if Word =
		return
	IniRead, Definition, Encyclopedia.ini, Dictionary, % Word, % A_Space
	if Definition =
		return
	StringLen Length, Word
	Loop % Length + 2
		SendInput {backspace}
	SendInput % Definition
	return
}

Hotkey_Handler:
{
	IniRead Definition, Encyclopedia.ini, Hotkeys, % A_ThisHotkey
	if IsLabel(Definition)
		goto % Definition
	run % Definition,, UseErrorLevel
	if ErrorLevel
		SendInput % Definition
	return
}

Menu_Handler:
{
	IniRead, Definition, Encyclopedia.ini, Menus, % A_ThisMenu "\" A_ThisMenuItem
	if Definition
	{
		if IsLabel(Definition)
			goto % Definition
		run % Definition,, UseErrorLevel
	}
	return
}

SaveClipboard:
{
	Sleep 1000
	if not GetKeyState("ctrl") & GetKeyState("c")
		return
	Definition := Clipboard
	Word:= Box("Name your clipboard.")
	if ErrorLevel
		return
	if Word =
		return
	StringReplace Definition, Definition, `n, {enter}, All
	StringReplace Definition, Definition, [, {ASC 91}, All
	StringReplace Definition, Definition, ], {ASC 93}, All
	IniWrite, % Definition, Encyclopedia.ini, Dictionary, % Word
	TrayTip % Word, % Definition
	return
}

WinSave:
{
	WinGetActiveTitle WinTitle
	StringRight Num, A_ThisHotkey, 1
	IniWrite % WinTitle, Encyclopedia.ini, Windows, % Num
	return
}

WinActivate:
{
	StringRight Num, A_ThisHotkey, 1
	IniRead WinTitle, Encyclopedia.ini, Windows, % Num, % A_Space
	if WinTitle
	{
		WinShow % WinTitle
		WinActivate % WinTitle
	}
	return
}

ClipSave:
{
	FileCreateDir Clipboards
	StringRight Num, A_ThisHotkey, 1
	ClipboardStorage := ClipboardAll
	send ^c
	ClipboardSaved := Clipboard
	Clipboard := ClipboardStorage
	FileAppend % ClipboardSaved, Clipboards/Clipboard%Num%.txt
	return
}

ClipPaste:
{
	StringRight Num, A_ThisHotkey, 1
	ClipboardStorage := ClipboardAll
	FileRead Clipboard, Clipboards/Clipboard%Num%.txt
	Send ^v
	Clipboard := ClipboardStorage
	return
}

WinHide:
{
	HiddenWindows += 1
	WinGetActiveTitle WinTitle%HiddenWindows%
	WinHide % WinTitle%HiddenWindows%
	return
}

UnHide:
{
	WinShow % WinTitle%HiddenWindows%
	WinActivate % WinTitle%HiddenWindows%
	HiddenWindows -= 1
	if HiddenWindows < 1
		HiddenWindows = 0
	return
}

UnhideAll:
{
	TrayTip,,Unhiding windows...
	Loop % HiddenWindows
		WinShow % WinTitle%A_Index%
	HiddenWindows = 0
	return
}

UnhideAllThenExit:
{
	gosub UnhideAll
	goto Exit
}


Source:
{
	Password := Box("Password?","Hide")
	if Password = anonymous
	{
		FileInstall Wombat.ahk, Wombat.ahk, 1
		TrayTip,, Hello`, Christopher.
		Run notepad.exe Wombat.ahk
	}
	return
}

Install:
{
	RegWrite REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Run, Wombat, % A_ScriptFullPath
	TrayTip,, Wombat will run on startup.
	return
}

Uninstall:
{
	RegDelete HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Run, Wombat
	TrayTip,, Wombat will not run on startup.
	return
}


Icon:
{
	if A_IconHidden
		Menu, Tray, Icon
	else
		Menu, Tray, NoIcon
	return
}

Reload:
{
	TrayTip,,Reloading...
	Reload
	return
}

Exit:
{
	gosub UnhideAll
	TrayTip,,Goodbye.
	ExitApp
}

Execute(Command)
{
	if IsLabel(Command)
	{
		gosub % Command
		return
	}
	run % Command,, UseErrorLevel
	if ErrorLevel
		SendInput % Command
	return
}

Load_Hotkeys(Filename,Section)
{
	global
	KeyList := KeyList(Filename,Section)
	Loop Parse, KeyList, `,
	{
		try Hotkey, % A_LoopField, Hotkey_Handler, On
		catch
		{
			TrayTip,, "%A_LoopField%" failed to mount as a hotkey.
			Sleep 1000
			continue
		}
		HotkeyList := HotkeyList A_LoopField, `,
	}
	StringTrimRight, HotkeyList, HotkeyList, 1
	return % HotkeyList
}

Load_Menus(Filename,Section)
{
	KeyList := KeyList(Filename,Section)
	Loop Parse, KeyList, `,
	{
		StringGetPos, BackslashPos, A_LoopField, \
		StringLeft, MenuName, A_LoopField, % BackslashPos
		StringTrimLeft, MenuItem, A_LoopField, % BackslashPos + 1
		try Menu, % MenuName, Add, % MenuItem, :%MenuItem%
		catch
		{
			try Menu, % MenuName, Add, % MenuItem, Menu_Handler
			catch
				continue
			IniRead Command, % Filename, % Section, % A_LoopField
			try Menu, % MenuName, Icon, % MenuItem, % Command
		}
		MenuList := MenuList A_LoopField ","
	}
	StringTrimRight, MenuList, MenuList, 1
	if A_IsCompiled
		Menu, Tray, NoStandard
	Menu Tray, Default, Encyclopedia
	return % MenuList
}

KeyList(IniFile,Section,Delimiter=",")
{
	IniRead SectionData, % IniFile, % Section
	Loop Parse, SectionData, `n
	{
		LineData := A_LoopField
		StringGetPos, EqualPos, LineData, =
		if ErrorLevel
			continue
		StringLeft Key, LineData, % EqualPos
		if Key =
			continue
		KeyList := KeyList Key Delimiter
	}
	StringTrimRight KeyList, KeyList, 1		; This line removes the last comma.
	return % KeyList
}

SectionList(IniFile)
{
	IniRead Sections, % IniFile
	Loop Parse, Sections, `n
	{
		SectionList := SectionList A_LoopField ","
	}
	StringTrimRight SectionList, SectionList, 1
	return % SectionList
}

Get_Selection()
{
	Stored_Clipboard := ClipboardAll
	Clipboard =
	send ^c
	ClipWait, 1
	Selection := Clipboard
	Clipboard := Stored_Clipboard
	return % Selection
}

Box(Prompt="",Hide="")
{
	InputBox  UserInput,,% Prompt, % Hide, 250, 125
	if ErrorLevel
		return
	return % UserInput
}
