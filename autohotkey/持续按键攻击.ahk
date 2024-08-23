
`::
{
    SoundPlay "voice\start.mp3"

    var := 100 ;
    Loop 100
    {
        Sleep(50)
        Send("{F5}")
        Send("{F6}")
        Send("{F7}")
        Send("{F8}")
        Send("{F10}")
        Send("{F11}")
        ; Send("3")
        Sleep(50)
        Loop 50{
            send "2"
        }
        
        var-- ;

        if (GetKeyState('``', "P") || var <= 1)
        {
            if (var <= 1){
                    SoundPlay "voice\stop.mp3"
                }
            else{
                    SoundPlay "voice\break.mp3"
            }
            break
        }        
    }    
}
