#Requires AutoHotkey v2.0

#Include <FindText>

pumkin_g_4s:="|<>*104$24.zxzzzzzzzzrzzzzzzzzzzzzzzzzzzyTTzy7Tvy1zvm6TvWTbveEbz+rXyPFVy1wUzn6UzulUwCT0s000s000s000k7n1kCTzkQDz0MDzU"

`::{
    capture_pumkin_g_4s := FindText(&X,&Y, 800,60,940,100,0.3,0.3,pumkin_g_4s)
    if(capture_pumkin_g_4s){
        Send("r")
        sleep(4000)
    }
}