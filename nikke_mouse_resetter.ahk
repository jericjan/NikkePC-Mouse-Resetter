#InstallMouseHook
#SingleInstance force
; Set the window title that you want to get the cursor position relative to
TargetTitle := "NIKKE"

global DebugMode
DebugMode := false


SetDefaultMouseSpeed, 0

debugTip(msg) {
	if DebugMode{
		ToolTip, %msg%
	}
	return
}

Loop
{
	WinGetPos, WinX, WinY, WinWidth, WinHeight, %TargetTitle%
	WinHandle := WinExist(WinTitle)
    ; Get the cursor position
    MouseGetPos, MouseX, MouseY
	WinGetTitle, WinTitle, A
    ; Calculate the cursor position relative to the window
    RelX := MouseX - WinX
    RelY := MouseY - WinY

    ; Display the cursor position relative to the window
    ;ToolTip, "Cursor Position Relative to Window:`nX: " %RelX% "`nY: " %RelY% "`n(" %WinWidth% %WinHeight% ")"
	X2 := WinX + WinWidth
	Y2 := WinY + WinHeight
	;ToolTip, ( %MouseX% %MouseY% ) `nx:  %WinX%  y:  %WinY% `nx:  %X2%  y:  %WinY% `nx:  %WinX%  y:  %Y2% `nx:  %X2%  y:  %Y2%
	if (WinTitle = TargetTitle) {
		WinWidth -= 1
		WinHeight -= 1
		if (MouseX <= 0 or MouseY <= 0 or MouseX>=WinWidth or MouseY>=WinHeight) {

			if GetKeyState("LButton", "P"){
				middleX := WinWidth/2
				middleY := WinHeight/2
				;ToolTip, bad holding mouse moving to %middleX% %middleY%
				if !GetKeyState("Shift", "P"){
					debugTip("bad holding mouse moving to center")
					BlockInput On
					Click, Up
					MouseMove, middleX, middleY
					Click, Down
					BlockInput Off
				}
				;Click, middleX, middleY
			} else {
				;ToolTip, bad NOT holding mouse
				debugTip("bad NOT holding mouse")
			}


		} else {
			debugTip("good (" MouseX " " MouseY ")`n" WinWidth " " WinHeight)
		}

		;ToolTip, ( %MouseX% %MouseY% ) `n%WinWidth% %WinHeight%
	} else {
		ToolTip
	}
    ; Wait for a short time before checking again
    Sleep, 1
}