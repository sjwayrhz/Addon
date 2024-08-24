#SuspendExempt
^`::
{
    if (A_IsSuspended) {
        SoundPlay "voice\the_script_is_resumed.mp3"
    } else {
        SoundPlay "voice\the_script_is_suspended.mp3"        
    }
    Suspend
}
#SuspendExempt false
monster := "|<>*38$300.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000w0000000007y0zkzk0DU1zzzzzzzzzzzzzs00007zzzzzzs000zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy3zTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz7zzzwH00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000U"
aac := "|<>*84$301.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwnzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyRzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzAzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzaTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyNzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzAzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzznDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzny0k7zzy2"
rebirth_3m := "|<>*113$24.zzwDzTs3y7k1w3k3s0UDs00TzU0zzs0zzw0TwBzjtjznzj0EyDPEzjPFvbPHtjPPwDPTbvzz03zzU3zzs7zzy7zzzbTzzyDzzw7zU"
rebirth_4m := "|<>*113$24.zzwzzzwDzTs3y7k1w3k3s0UDs00TzU0zzs0zzw0Tz9zjy/znyf0EwfPEtjPFs7PHzDPPzfPTVvzz03zzU3zzs7zzy7zzzbTzzyDzzw7zU"
equipment_points:="|<>*103$98.0zzxzzzzzzw7zjzznzzzTzzzzxzQzvzjxzzzzzzzzzDrjzztzTkPhUk3VUXxv1g4MEBqvNgarNhzQrPBik7RiqtNZmvTkRmrPbTbPhiKM1irxyQhqwLxqvPhaLvhzTr/RjlzNgqPNZqvTrxqrPg0kMBUqNVinxz1hqMTzrzvzzzzzzzzzzzzzxzyzzzzzzzzzzzzzzTzjzzzzzzzzzzzs"

#Include <FindText>

`::
{
    SoundPlay "voice\start.mp3"

    Loop 1000
    {
        if (A_IsSuspended){
            SoundPlay "voice\the_script_is_suspended.mp3"
            break
        }

        ; 循环攻击退出条件1：怪物死亡，怪物血条变成黑色，停止攻击
        ; 循环攻击退出条件2：鼠标移动到玩家自身血条，会看到"equipment_points"，此时会停止
        capture_monster := FindText(&X,&Y, 804,23,1118,71,0.1,0.1,monster)
        capture_equipment_points := FindText(&X,&Y, 308,67,477,110,0.2,0.2,equipment_points)
        if (capture_monster){
            if (Random(1, 10) == 1){
                SoundPlay "voice\an_enemy_has_been_slayed.mp3"
            }
            break
        }
        else if (capture_equipment_points){
            SoundPlay "voice\quit_auto_attack_mode.mp3"
            break
        }

        capture_aac := FindText(&X,&Y, 0,26,311,73,0.1,0.1,aac)
        if (capture_aac){
            SoundPlay "voice\you_have_been_slain.mp3"
            capture_rebirth_3m := FindText(&X:='wait', &Y:=60, 1,61,311,164,0.1,0.1,rebirth_3m)
            capture_rebirth_4m := FindText(&X:='wait', &Y:=60,164,0.1,0.1,rebirth_4m)
            if(capture_rebirth_3m || capture_rebirth_4m){
                SoundPlay "voice\rebirth_trauma.mp3.mp3"
                break
            }
        }
        

        ; 循环攻击技能为 F1,F2,F3,F4,F5,F6,z,x,2 其中2号按键攻击次数最多
        Sleep(50)
        Send("{F6}")
        Send("{F5}")
        Send("{F4}")
        Send("{F3}")
        Send("{F2}")
        Send("{F1}")
        ; Send("3")
        Send("z")
        Send("x")
        Sleep(50)
        Loop 50{
            send "2"
        }      
    }    
}
