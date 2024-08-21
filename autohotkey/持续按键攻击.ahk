; 按ctrl+e触发，每间隔50毫秒按一次E，重复100次。
; 定义热键 Ctrl+E
^e::
    Loop, 100
    {
        SendInput, {e}
        Sleep, 50
    }
return