#Requires AutoHotkey v2.0

#Include <FindText>

; Text1 = Battle Focus  |  Text2 = Freerunner
Text:="|<a>*85$38.DxTtzzlz3yTzy1kzbzzUEDtzztxxyDzyK4TnzzU07wzztzUzDzyGNDvzzY0nyTztYATbzzszbxzzyDszDzzlz/szzwTsSDzzXT7zzzsrlzbzz5y3xzzlTnzzzwLzzrnz7zz/szlzzzwTyTzDwzzbzbwTzlzswDzkzzU7zwTzyDztzTzzzzz7zzzzzX7zzzzkUzzzzz0Dzzrzs3zznzy0Tznzzn3znzzyMzvzzzmDzzs"
Text.="|<b>*121$39.kRzzzzy27kzzzrrM0Dzywa00Dzk0000zywm001za4Es06wUWDU03Y0lw00DkQDU07z03w01zs0DU0Tr01w03yE0DU0vX01w03AM0D00Nr01s03as0Tn0wr1zzw7UszzzkxrzzzzzYzzzzzzbuTzzzzz1zwTzk0DzU3zU0zs0Dy01z00zk0Ts03z01z05zs0Ts0zzU3z0Dzw0zs1zzA7z0DzzUzsEzzyjzjzw"
Text.="|<c>*101$39.UzzwU040Dzs00Dtzy005zTzU00UnTw005yty001jb7Y00RwwRU07jjU001zzy000Dzzs001zzz000Dzzw003zzzU00zzzw00DzzzU01zzzy00Dzzzs01zzzzU03zzzw007zzzA00Tzzxm7wzzzhwzzzzxjvzzzzizTzzzzntzzzzzTzzzzznzzzjzyTzztzzvzzzDzzTzztzzzzzzzzzzzzrzzzzztzzzzzyTzzzzzbzzzzzxzzzzzzU"
Text.="|<d>*105$39.zzzzzzy3DzzzzkEzzzzywnzzzzrqTzzzy27zxzzraTzDzywvznzzraTwzzyy7z7zzzzzqzzzzzxjzzzzyTzzzzzbTzzzz5rzzzz0BzzzzU0Tzzzs03zzzw04zzzy01Dzzz001zzzs00Tvzz007yTzs01y1zz00DUTzs03znzz00zwTzs07z1zz01DUDzs0Ps3zz07w0Tzs0z03zz07w0zzs0T07zz0001zzs000Dzz0001zzs000TzzU"
Text.="|<e>*104$38.1zzzvvkP3zzyRsqTzzrLdrzrwkORzwzhybTz7zQdbzkzp39zq7xEszzlxkDvzyyC0Qzzz3U3zsy0w0Dz7UDU0zks3s03z20z00SM0DwA3n03zbUC00zyy000Dznk003zy3000zzsk00DzzU003zySs00zzbz1UDzzzUA3zzzk00zzzk00Dzz0003zUs000zsA000Dzi0003zzk000zzw000DzzU003zzs000zzw0008"
Text.="|<f>*113$41.k1zzzzzu1zzzzzU1Tzzzy10TzzzswFzzzzlufzzzzU14jzzz7m8DzzyDoEDzzwLcUDzzwjN0BzzvDm0NzzsDk03zzsDk03zzsTk06zzsTk05zwkTU01jw0zU03Tw0zU06zy0zU05zy0zU09zy0zU03Tz0zU04zz1zU01zxUzU03zw0zU03zw0zU07zy0zY0Dzz0T00Tzk0D80zzs0D01zzw07U3zzy0307zzw000DzzU000Tzzs000zzzy001zzzw003zzz0007zzzs008"

`::
{
    SoundPlay "voice\start.mp3"
    Loop (100)
    {
        capture := FindText(&X,&Y, 0,0,0,0,0.1,0.1,Text)
        if (!capture) {
        }
        else {
            for k,v in capture{
                if v.id == "a"{
                    Send("{F5}")
                }
                else if v.id == "b"{
                    Send("{F6}")
                }
                else if v.id == "c"{
                    Send("{F7}")
                }
                else if v.id == "d"{
                    Send("{F8}")
                }
                else if v.id == "e"{
                    Send("{F10}")
                }
                else if v.id == "f"{
                    Send("{F11}")
                }
            }                    
        }
        Loop(50){
            Send("e")
            sleep(20)
        }   
    }
    SoundPlay "voice\break.mp3"

}

return