DirCreate "voice"

FileInstall "voice\the_script_is_resumed.mp3", A_WorkingDir "\voice\the_script_is_resumed.mp3",1
FileInstall "voice\the_script_is_suspended.mp3", A_WorkingDir "\voice\the_script_is_suspended.mp3",1
FileInstall "voice\start.mp3", A_WorkingDir "\voice\start.mp3",1
FileInstall "voice\quit_auto_attack_mode.mp3", A_WorkingDir "\voice\quit_auto_attack_mode.mp3",1
FileInstall "voice\an_enemy_has_been_slayed.mp3", A_WorkingDir "\voice\an_enemy_has_been_slayed.mp3",1
FileInstall "voice\you_have_been_slain.mp3", A_WorkingDir "\voice\you_have_been_slain.mp3",1
FileInstall "voice\rebirth_trauma.mp3", A_WorkingDir "\voice\rebirth_trauma.mp3",1


#SuspendExempt
^`::
{
    if (A_IsSuspended) {
        SoundPlay A_WorkingDir "\voice\the_script_is_resumed.mp3"
    } else {
        SoundPlay A_WorkingDir "\voice\the_script_is_suspended.mp3"        
    }
    Suspend
}
#SuspendExempt false
monster := "|<>*38$300.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000w0000000007y0zkzk0DU1zzzzzzzzzzzzzs00007zzzzzzs000zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy3zTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz7zzzwH00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000U"
equipment_points:="|<>*103$98.0zzxzzzzzzw7zjzznzzzTzzzzxzQzvzjxzzzzzzzzzDrjzztzTkPhUk3VUXxv1g4MEBqvNgarNhzQrPBik7RiqtNZmvTkRmrPbTbPhiKM1irxyQhqwLxqvPhaLvhzTr/RjlzNgqPNZqvTrxqrPg0kMBUqNVinxz1hqMTzrzvzzzzzzzzzzzzzxzyzzzzzzzzzzzzzzTzjzzzzzzzzzzzs"
; threshold_cooldown截取的是刚刚死亡，关键词“cooldown”的图片，threshold截取的是可以点击respawn的时候，中间图片
threshold_cooldown:="|<>*145$59.00010E000000020U00000004100003lsS8yDAlDwqNaHAn9aNkcG4Y92PgnUEoB8G6rF30VcOEYBvW653EYV8Fr4CPAn9aNXC8LXkyFwS6MEk"
threshold := "|<>*154$159.200000000000000000000000000M000600000U0U000000000000U30030k0001Y0400000000000040Mk0M60000AU0U000000000000U3TbrUzDD3nrs7swT0TDXlsz7lw0PAnM6NXAnAn0nAnA6NanNaNaNU3Na30lgMkNaM6M6M0lg48AlgOA0NwwM6BXyTAn0n7nk7xsUDYBzkU3TVv0VgTbNaM4Nq7Uz3w3gVzq40TAXM69W4XAn0X8mA496XFaBWEU3vYP0nANaNaM4N6FUn8qOAnAnA0PyyQ7tVwzin0nDvs3twSTrsyDU2A1U0002000000040A2000k0000000000000000000000000600000300000000000000000001k00000M0000600000000000000Q0060M310000k00000000000003000k7kwy0yNjDU0wyTDVtaNy0ww3kDDa3AkAnAnA06AnBaNYvAkAn0n0nAkN306NaEzwlXMAEArNa06M0M6EU3MM7nAq606Dvl37auAk7n0T0ns0P31qNakk0ly78Pgxla1qM7M6M638M8nAm6068GBWFXiAk8n0X0m4kNa1aNaNU0laFgmANla16M4M6Nw3bkDvwtw067ntwTnAAkDvUzUts00M0000600000800000000000000000000000001000000000000000000000000008000000000000U"

#Include <FindText>

`::
{
    SoundPlay A_WorkingDir "\voice\start.mp3"

    start_time := A_TickCount

    Loop {
        if (A_IsSuspended){
            SoundPlay A_WorkingDir "\voice\the_script_is_suspended.mp3"
            break
        }

        ; 循环攻击退出条件1：怪物死亡，怪物血条变成黑色，停止攻击
        ; 循环攻击退出条件2：鼠标移动到玩家自身血条，会看到"equipment_points"，此时会停止
        ; 循环攻击退出条件3: 玩家自身死亡
        capture_monster := FindText(&X,&Y, 804,23,1118,71,0.1,0.1,monster)
        capture_equipment_points := FindText(&X,&Y, 308,67,477,110,0.2,0.2,equipment_points)
        capture_threshold_cooldown := FindText(&X,&Y, 908,371,996,395,0.1,0.1,threshold_cooldown)
        capture_threshold := FindText(&X,&Y, 847,310,1078,360,0.1,0.1,threshold)
        
        if (capture_monster){
            Loop 3 {
                send "f"
                Sleep(1000)
            }

            elapsed_time := A_TickCount - start_time

            if (elapsed_time > 15000)  {
                SoundPlay A_WorkingDir "\voice\an_enemy_has_been_slayed.mp3"
            }
            break

        }
        else if (capture_equipment_points){
            SoundPlay A_WorkingDir "\voice\quit_auto_attack_mode.mp3"
            break
        }
        else if (capture_threshold_cooldown||capture_threshold){
            SoundPlay A_WorkingDir "\voice\you_have_been_slain.mp3"
            break
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
