:*:urlenc::
	delay := 500	
	ClipWait
	oldClip := Clipboard
	Clipboard := Format("{:L}", MakeNiceURL())
	ClipWait
    SendInput, ^v
	Sleep, %delay%
	Clipboard = %oldClip%
	ClipWait
return
:*:urldec::
	delay := 500
	ClipWait
	oldClip := Clipboard
	Clipboard := Format("{:T}", MakeTitleFromNiceURL())
	ClipWait
    SendInput, ^v
	Sleep, %delay%
	Clipboard = %oldClip%
	ClipWait
return

MakeNiceURL()
{
	NiceUrl := Trim(Clipboard)
	;MsgBox %NiceUrl%
	While InStr(NiceUrl, "  ") <> 0
	{
		StringReplace, NiceUrl, NiceUrl, %A_Space%%A_Space%, %A_Space%, All
	}
	StringReplace, NiceUrl, NiceUrl, :, , All
	StringReplace, NiceUrl, NiceUrl, `;, , All
	StringReplace, NiceUrl, NiceUrl, `,, , All
	StringReplace, NiceUrl, NiceUrl, !, , All
	StringReplace, NiceUrl, NiceUrl, ., , All
	StringReplace, NiceUrl, NiceUrl, /, -, All
	StringReplace, NiceUrl, NiceUrl, \, -, All
	StringReplace, NiceUrl, NiceUrl, #, , All
	StringReplace, NiceUrl, NiceUrl, (, , All
	StringReplace, NiceUrl, NiceUrl, ), , All
	StringReplace, NiceUrl, NiceUrl, [, , All
	StringReplace, NiceUrl, NiceUrl, ], , All
	StringReplace, NiceUrl, NiceUrl, `{, , All
	StringReplace, NiceUrl, NiceUrl, `}, , All
	StringReplace, NiceUrl, NiceUrl, ', , All
	StringReplace, NiceUrl, NiceUrl, *, , All
	StringReplace, NiceUrl, NiceUrl, `", , All
	StringReplace, NiceUrl, NiceUrl,  %A_Space%, -, All
	While InStr(NiceUrl, "--") <> 0
	{
		StringReplace, NiceUrl, NiceUrl, --, -, All
	}
	;MsgBox %NiceUrl%
	return NiceUrl
}

MakeTitleFromNiceURL()
{
	NiceUrl := Trim(Clipboard)
	StringReplace, NiceUrl, NiceUrl,  -, %A_Space%, All
	While InStr(NiceUrl, "  ") <> 0
	{
		StringReplace, NiceUrl, NiceUrl, %A_Space%%A_Space%, %A_Space%, All
	}
	StringUpper, NiceUrl, NiceUrl, T
	return NiceUrl
}