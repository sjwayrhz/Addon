; 同时查找两个目标
#Include <FindText>

; Text1 = Battle Focus  |  Text2 = Freerunner
Text1:="|<>*85$38.DxTtzzlz3yTzy1kzbzzUEDtzztxxyDzyK4TnzzU07wzztzUzDzyGNDvzzY0nyTztYATbzzszbxzzyDszDzzlz/szzwTsSDzzXT7zzzsrlzbzz5y3xzzlTnzzzwLzzrnz7zz/szlzzzwTyTzDwzzbzbwTzlzswDzkzzU7zwTzyDztzTzzzzz7zzzzzX7zzzzkUzzzzz0Dzzrzs3zznzy0Tznzzn3znzzyMzvzzzmDzzs"
Text2:="|<>*91$39.7zzzzzszzzzzz0Nyzzzs27jzzz7rTrzzswCzzzz00Dzzzswnzzzz7aHzzzsy21zzz7sk09zVzw007UDzk0001zy00003zs0000DzU0000Ty00000zw00001zk00007y00000Tk00001zU00007w006007k00zU0z207zU7wwTzzkTvbzzzXzlzzzyDwTzzzVzbzzzwDxbzzz3z3zzzszUzzzyDsTzzzny3zzzxz0zzzzzkDzzzzsTzzzzzzzzzzzzzzzzzzzzzw"

; 在这里设置搜索图像的循环
while true
{
    ; 捕捉两个目标
    capture1 := FindText(&X:="wait", &Y:=3, 0,0,0,0,0,0,Text1)
    capture2 := FindText(&X:="wait", &Y:=3, 0,0,0,0,0,0,Text2)

    if (capture1)
    {
        Send("{F5}")
    }
    
    if (capture2)
    {
        Send("{F6}")
    }

    ; 延迟1秒后继续搜索
    Sleep 1000
}


return
