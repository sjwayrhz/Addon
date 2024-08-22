#Include <FindText>

; 定义图像模板1
Template1 := "|<>*91$42.zzzzzzzzzzzzzzsDzzzzzsBzDzzzvlzYzzzvxxnTzzsBxnjzzvxwtjzzvxytzzzvxrtzzzvxrxzzzzzvxzzzzznzzzzzzvzzzzzzzzrzzzzzzrzzzzDzrzzzzDznzzzzDzszzzzDzszzzy7zzzzzw7zzrzzs7zzDzzk3zyDzzk3zsDzzk1zU7zzU1zU7zzU1z07zw03z01zw03z00Tw63z00zw43z00ty03z003q07zU07k2LzU0TkGTzcMzU0Tz8NrW1TzMHrXdTzN7bbtTzRbXzzzzzzzU"

; 定义图像模板2
Template2 := "|<>*91$42.zzzzzzzzzzzzzzzzzzzzzzzzzzzzbzzzzzzzbzzzzz7bvzzzzbvzzzznvzzzzTvzzzzxznzzzzTxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzrxnzzzzxxnzzzzTxnzzzzyvzzzznvzzzzzvzzzz7bvzzzzzbzzzzzzb"

SetTimer, FindImage1, 500  ; 每500毫秒检查一次第一个图像
SetTimer, FindImage2, 500  ; 每500毫秒检查一次第二个图像

return

FindImage1:
{
    ; 在屏幕上搜索第一个图像
    ok1 := FindText(&X1:="wait", &Y1:=3, 0,0,0,0,0,0,Template1)
    if (ok1)
    {
        OutputDebug "Found first image at X=" X1 ", Y=" Y1
    }
}

FindImage2:
{
    ; 在屏幕上搜索第二个图像
    ok2 := FindText(&X2:="wait2", &Y2:=3, 0,0,0,0,0,0,Template2)
    if (ok2)
    {
        OutputDebug "Found second image at X=" X2 ", Y=" Y2
        Send("{F2}")  ; 发送F2按键
    }
}