#Requires AutoHotkey v2.0

#Include <FindText>

fish_debuff:="|<>*109$28.zzzzzCDzli3zzVwDzyD0zzkT3zy0sDzVvDQ0TtzkDzjzATxy7yzzvDzzjixDo4frU0HjC01izc06rqU0Az600Tzk007y000Dk000z0003w000Dk001zU00DzU03zzUU"

fish_7_4s:="|<>*104$28.z1zszlnzDzDbxzs3rjzVyBzy1kTzw60zzkk1zza07zzrUDzymCTzu9zzzugDzz+rzztj6zzUT9zznazzzf7z0bbw0087w00UTs42N604DwM00tk0U"
fish_5_4s:="|<>*108$27.zy0Lzk00Ts081zkPMDwQ1kz6837XW0ANdU9nMRnWCLTA9WjaFAJYy83cjs2TLVQkmxzaKrXimUT8SDbBUlywS66TzsoMHzyUlzzq1wASk31SyHYL7tsIVza3dzykDzU"
fish_4_4s:="|<>*104$27.zzzzzUTzzsVzzzNzkDrw00yzs07jzk1xzy0DzzU1vzs0DTt71zy9yDzpMHzwfTTzBsvzs7nbztnKTjj6nzzznDzC88zr05bzU0ozss7LyNlwzi66zvUw3zw30A"
fish_6_4s:="|<>*115$28.0000A2000kz0097D000QD200UDs030Dk04QTY0TtjM0Abns1Wzgk6f3v0mxxs3PlvkM7nj0wtjS1vlyy0tzzw03zxM00zVY01zzks1zrzPXDzkzUU"
fish_t_4s:="|<>*103$26.zzw3zzy4TUTwrk03yw03zjU3zxs0zzS17zzVszysmDzi8bzzq/3zz+rzzawTz87mzbnartywSwnzzz88xzqU3jxM0Dzi1lzrlnjzMMRzUQ3zs"

fish_died:="|<>*87$428.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztrzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

while(true){

    ; 检查鱼是否死亡
    capture_fish_died := FindText(&X,&Y, 794,16,1249,72,0.1,0.1,fish_died)
    if(capture_fish_died){
        SoundPlay "voice\an_enemy_has_been_slayed.mp3"
        sleep(5000)
        break
    }

    ; 小键盘按键7，在剩余4秒的时候
    capture_fish_7_4s := FindText(&X,&Y, 793,52,965,116,0.3,0.3,fish_7_4s)
    if(capture_fish_7_4s){
        Send "{Numpad7}"
        sleep(4500)
    }
    ; 小键盘按键5，在剩余4秒的时候
    capture_fish_5_4s := FindText(&X,&Y, 793,52,965,116,0.3,0.3,fish_5_4s)
    if(capture_fish_5_4s){
        Send "{Numpad5}"
        sleep(4500)
    }
    ;小键盘按键4，在剩余4秒
    capture_fish_4_4s := FindText(&X,&Y, 793,52,965,116,0.3,0.3,fish_4_4s)
    if(capture_fish_4_4s){
        Send "{Numpad4}"
        sleep(2000)
        capture_fish_debuff := FindText(&X,&Y, 751,53,943,148,0.3,0.3,fish_debuff)
        if(capture_fish_debuff){
            Send "{Numpad0}"
            sleep(1500)
        }
    }
    ;小键盘按键6，在剩余4秒
    capture_fish_6_4s := FindText(&X,&Y, 793,52,965,116,0.3,0.3,fish_6_4s)
    if(capture_fish_6_4s){
        Send "{Numpad6}"
        sleep(2000)
        capture_fish_debuff := FindText(&X,&Y, 751,53,943,148,0.3,0.3,fish_debuff)
        if(capture_fish_debuff){
            Send "{Numpad0}"
            sleep(1500)
        }
    }
    ;小键盘按键t，在剩余4秒
    capture_fish_t_4s := FindText(&X,&Y, 793,52,965,116,0.3,0.3,fish_t_4s)
    if(capture_fish_t_4s){
        Send "t"
        sleep(2000)
        capture_fish_debuff := FindText(&X,&Y, 751,53,943,148,0.3,0.3,fish_debuff)
        if(capture_fish_debuff){
            Send "{Numpad0}"
            sleep(1500)
        }
    }
}
