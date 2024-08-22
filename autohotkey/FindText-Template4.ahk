#Requires AutoHotkey v2.0

; 多线程同时查找两个目标
#Include <FindText>

; Text1 = Battle Focus  |  Text2 = Freerunner
Text1 := "|<>*85$38.DxTtzzlz3yTzy1kzbzzUEDtzztxxyDzyK4TnzzU07wzztzUzDzyGNDvzzY0nyTztYATbzzszbxzzyDszDzzlz/szzwTsSDzzXT7zzzsrlzbzz5y3xzzlTnzzzwLzzrnz7zz/szlzzzwTyTzDwzzbzbwTzlzswDzkzzU7zwTzyDztzTzzzzz7zzzzzX7zzzzkUzzzzz0Dzzrzs3zznzy0Tznzzn3znzzyMzvzzzmDzzs"
Text2 := "|<>*91$39.7zzzzzszzzzzz0Nyzzzs27jzzz7rTrzzswCzzzz00Dzzzswnzzzz7aHzzzsy21zzz7sk09zVzw007UDzk0001zy00003zs0000DzU0000Ty00000zw00001zk00007y00000Tk00001zU00007w006007k00zU0z207zU7wwTzzkTvbzzzXzlzzzyDwTzzzVzbzzzwDxbzzz3z3zzzszUzzzyDsTzzzny3zzzxz0zzzzzkDzzzzsTzzzzzzzzzzzzzzzzzzzzzw"

; 搜索图像的函数
SearchImage(text, key) {
    while true {
        capture := FindText(&X:="wait", &Y:=3, 0,0,0,0,0,0, text)
        if (capture) {
            Send(key)
        }
        Sleep 1000
    }
}

; 启动两个线程
Thread1 := Thread.new(SearchImage, Text1, "{F5}")
Thread2 := Thread.new(SearchImage, Text2, "{F6}")

; 等待线程退出
Thread1.join()
Thread2.join()

return