; the urlenc shortcut takes the contents of the clipboard and replaces with a hyphen the following characters: :;,!./\#()[]{}'*" It also replaces multiple consecutive spaces with a single hyphen.
; the urldec shortcut takes the contents of the clipboard and replaces all hyphens with spaces
; to use either of these shortcuts make sure you have text copied in your clipboard then write the shortcut in the application where you want to have the transformation.

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