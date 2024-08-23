#Requires AutoHotkey v2.0

#Include <FindText>

Text:="|<>*89$34.zzzzzzzzzzrzzzzxTzzzzzyTzzzzvvzzzzzbzzzzyDzzzzsTzzzzUTzzzy0Tzzzs0zyzzk1k3zz020Tzy001zzw00Dzzs01zzzs0TzzzyzzzzztzzzzzjzzzzyzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzziTzzzxxzzzzrzzzzzTzzzzxlzzzzrrzzzzTTzzyQtzzzzsDzzzzzzzzzzzzzU"

`::
{
    SoundPlay "voice\脚本启动.mp3"
    var := 1000 ;
    Loop 1000{
        capture := FindText(&X,&Y, 950,730,1020,800,0.3,0.3,Text)
        if (capture){
            SoundPlay "voice\发现大米开始采集.mp3"
            send("g")
            sleep(5000)
        }
        var--
    }    
}