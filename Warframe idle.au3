#NoTrayIcon
#RequireAdmin
#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile_x64=QQ音乐.exe
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#AccAu3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/cs=1 /cn=1 /cf=1 /cv=1 /sf=1 /sv=1 /sci=1
#AccAu3Wrapper_DBSupport=y
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>
#include <AutoItConstants.au3>
#include <WinAPI.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>


Opt("SendKeyDownDelay", 200)
Opt("SendKeyDelay", 200)
Opt("MouseCoordMode", 1)
Opt("MouseClickDragDelay", 500)


HotKeySet("{F4}", "_Terminate")
HotKeySet("{F3}", "TogglePause")
$hwnd = WinGetHandle("Warframe")
Global $g_bPaused = False
Global $a = 0

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WindowsConstants.au3>
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("QQ音乐", 230, 128, 397, 293)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")

$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
_GUICtrlStatusBar_SetBkColor($StatusBar1, 0xD1B499)
$Checkbox1 = GUICtrlCreateCheckbox("Mag吸取", 56, 24, 97, 17)
GUICtrlSetOnEvent(-1, "Checkbox1Click")
$Checkbox2 = GUICtrlCreateCheckbox("切指挥官", 56, 56, 97, 17)
GUICtrlSetOnEvent(-1, "Checkbox2Click")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $idClose
			ExitLoop
	EndSwitch
WEnd

Func Checkbox1Click()
	If WinExists("Warframe") Then
		Mag()
	Else
		MsgBox($MB_SYSTEMMODAL, "提示", "游戏未启动 本程序将自动关闭", 10)
		GUIDelete
	EndIf
EndFunc

Func Checkbox2Click()
	If WinExists("Warframe") Then
		Commander()
	Else
		MsgBox($MB_SYSTEMMODAL, "提示", "游戏未启动 本程序将自动关闭", 10)
		GUIDelete
	EndIf
EndFunc

Func Form1Close()
	Exit
	GUIDelete
EndFunc







#cs
While 1 ;monitor
	If WinExists("Warframe") Then
		If WinActive("Warframe") Then
			Mag()
		Else
			Sleep(100)
		EndIf
	Else
		MsgBox($MB_SYSTEMMODAL, "提示", "游戏未启动 本程序将自动关闭", 10)
		_Terminate()
	EndIf
WEnd
#CE



Func Mag()
	While _IsChecked($Checkbox1)
	$magtime = (12 + Random(1, 2) - Random(1, 2)) * 1000
	Send("1")
	Sleep($magtime)
	WEnd
EndFunc   ;==>Mag

Func Commander()
	While _IsChecked($Checkbox2)
	$idletime = (58 + Random(1, 20) - Random(1, 20)) * 1000
	$refreshtime = (3 + Random(0, 1) - Random(0, 1)) * 1000
	;$a = $a + 1
	Sleep(100)
	;MouseClick("left")
	Send("5")
	Sleep($refreshtime)
	Send("5")
	Sleep($idletime)
	WEnd
EndFunc   ;==>Commander

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

#cs
	Func Press()
	Sleep(100)
	;$a = $a + 1
	$idletime = 80 + Random(1,20) - Random (1,20)
	$refreshtime = 3 + Random(0,1) - Random (0,1)
	ControlSend($handle1, "", "", "5")
	Sleep($refreshtime)
	ControlSend($handle1, "", "", "5")
	Sleep($idletime)
	;ControlSend($handle1, "", "", "{SPACE}")
	;$a = 0
	EndFunc   ;==>Press
#ce



Func TogglePause()
	$g_bPaused = Not $g_bPaused
	If $g_bPaused = True Then
		TrayTip("已暂停", "F3恢复挂机", 0, $TIP_ICONASTERISK)
	EndIf
	While $g_bPaused
		Sleep(100)
	WEnd
	TrayTip("正在挂机", "按下F3暂停", 3, $TIP_ICONASTERISK)
EndFunc   ;==>TogglePause

Func _Terminate()
	TrayTip("已停止", "脚本已关闭", 0, $TIP_ICONASTERISK)
	Exit
EndFunc   ;==>_Terminate
