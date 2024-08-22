
`::
{
    SoundPlay "*16"
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

        if GetKeyState('``', "P")
            {
                SoundPlay "*64"
                Break
            }
    }
}
