#Include <FindText>

Text:="|<>*91$42.zzzzzzzzzzzzzzsDzzzzzsBzDzzzvlzYzzzvxxnTzzsBxnjzzvxwtjzzvxytzzzvxrtzzzvxrxzzzzzvxzzzzznzzzzzzvzzzzzzzzrzzzzzzrzzzzDzrzzzzDznzzzzDzszzzzDzszzzy7zzzzzw7zzrzzs7zzDzzk3zyDzzk3zsDzzk1zU7zzU1zU7zzU1z07zw03z01zw03z00Tw63z00zw43z00ty03z003q07zU07k2LzU0TkGTzcMzU0Tz8NrW1TzMHrXdTzN7bbtTzRbXzzzzzzzU"

; 在这里设置搜索图像的循环
while true
{
    ; 在屏幕上搜索图像
    ok := FindText(&X:="wait", &Y:=3, 0,0,0,0,0,0,Text)
    if (ok)
    {
        OutputDebug "Found image at X=" X ", Y=" Y
        Send("{F1}")
    }
    else
    {
        OutputDebug "Image not found"
    }

    ; 延迟1秒后继续搜索
    Sleep 1000
}


return