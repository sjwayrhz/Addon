#Requires AutoHotkey v2.0

#Include <FindText>

fish_debuff:="|<>*109$28.zzzzzCDzli3zzVwDzyD0zzkT3zy0sDzVvDQ0TtzkDzjzATxy7yzzvDzzjixDo4frU0HjC01izc06rqU0Az600Tzk007y000Dk000z0003w000Dk001zU00DzU03zzUU"

key5:="|<>*104$28.z1zszlnzDzDbxzs3rjzVyBzy1kTzw60zzkk1zza07zzrUDzymCTzu9zzzugDzz+rzztj6zzUT9zznazzzf7z0bbw0087w00UTs42N604DwM00tk0U"
key4:="|<>*108$27.zy0Lzk00Ts081zkPMDwQ1kz6837XW0ANdU9nMRnWCLTA9WjaFAJYy83cjs2TLVQkmxzaKrXimUT8SDbBUlywS66TzsoMHzyUlzzq1wASk31SyHYL7tsIVza3dzykDzU"
key3:="|<>*104$27.zzzzzUTzzsVzzzNzkDrw00yzs07jzk1xzy0DzzU1vzs0DTt71zy9yDzpMHzwfTTzBsvzs7nbztnKTjj6nzzznDzC88zr05bzU0ozss7LyNlwzi66zvUw3zw30A"
key2:="|<>*115$28.0000A2000kz0097D000QD200UDs030Dk04QTY0TtjM0Abns1Wzgk6f3v0mxxs3PlvkM7nj0wtjS1vlyy0tzzw03zxM00zVY01zzks1zrzPXDzkzUU"
key1:="|<>*103$26.zzw3zzy4TUTwrk03yw03zjU3zxs0zzS17zzVszysmDzi8bzzq/3zz+rzzawTz87mzbnartywSwnzzz88xzqU3jxM0Dzi1lzrlnjzMMRzUQ3zs"


fish_spawn:="|<>*92$430.k0000000000000000000000000000000000000000000000000000000000000000000000Azzzzzzzzzzzzzzzzzzzzzzzzzzzzzz003zzzzzzzzzzz000000000000000000000000000Lzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy7X000007k1Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk005zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkLzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz1Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw5zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkLzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyMks1Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzl0101zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy1VUM7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs0U1UTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs11a1zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzVU6E7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy6681Dzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs0104zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz000000Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy003zzzzyQ00000000000000000000000007zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz3wTzzzk000001zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz333WTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz00000000000000001Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs00000000000000000000000005zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU0000000000000000000000000Hzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy00000000000000000000000001Dzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk00000000000000000000000004Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz00000000000000000000000000Ezzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000c"
fish_died:="|<>*87$428.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztrzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

checkdebuff(){
    capture_fish_debuff := FindText(&X,&Y, 751,53,943,148,0.3,0.3,fish_debuff)
        if(capture_fish_debuff){
            Send "{Numpad0}"
        }
    }

`::
{
    SoundPlay "voice\mirage-sport-fishing.mp3"

    while (true){
        ; 检查鱼是否上钩
        capture_fish_spawn := FindText(&X,&Y, 805,26,1246,73,0.1,0.1,fish_spawn)
        if(!capture_fish_spawn){
            sleep(1000) 
        }
        else {
            SoundPlay "voice\pink-marlin.mp3"
            break
        }
    }

    while(true){

        ; 检查鱼是否死亡
        capture_fish_died := FindText(&X,&Y, 794,16,1249,72,0.1,0.1,fish_died)
        if(capture_fish_died){
            SoundPlay "voice\an_enemy_has_been_slayed.mp3"
            sleep(5000)
            break
        }    

        ; 小键盘按键7，在剩余4秒的时候
        capture_key5 := FindText(&X,&Y, 793,52,965,116,0.3,0.3,key5)
        if(capture_key5){
            Send "{Numpad7}"
            sleep(4000)
        }
        ; 小键盘按键5，在剩余4秒的时候
        capture_key4 := FindText(&X,&Y, 793,52,965,116,0.3,0.3,key4)
        if(capture_key4){
            Send "{Numpad5}"
            sleep(4000)
        }
        ;小键盘按键4，在剩余4秒
        capture_key3 := FindText(&X,&Y, 793,52,965,116,0.2,0.2,key3)
        if(capture_key3){
            Send "{Numpad4}"
            sleep(2000)
            checkdebuff()
        }
        ;小键盘按键6，在剩余4秒
        capture_key2 := FindText(&X,&Y, 793,52,965,116,0.2,0.2,key2)
        if(capture_key2){
            Send "{Numpad6}"
            sleep(2000)
            checkdebuff()
        }
        ;小键盘按键t，在剩余4秒
        capture_key1 := FindText(&X,&Y, 793,52,965,116,0.2,0.2,key1)
        if(capture_key1){
            Send "t"
            sleep(2000)
            checkdebuff()
        }
    }
}