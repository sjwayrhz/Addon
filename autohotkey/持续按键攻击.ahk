
`::
{
    SoundPlay "voice\start.mp3"

    var := 100 ;
    Loop 100
    {
        send "3"
        Sleep(10)
        send "!q"
        Sleep(10)
        send "!e"
        Sleep(10)
        send "2"
        Sleep(10)
        send "1"
        Sleep(10)

        Send "e"
        Sleep(50)

        var-- ;

        if (GetKeyState('``', "P") || var <= 1)
        {
            if (var <= 1)
                {
                    SoundPlay "voice\stop.mp3"
                }
                else
                {
                    SoundPlay "voice\break.mp3"
                }
                Break
        }        
    }    
}
