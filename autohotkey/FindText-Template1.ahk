#Include <FindText>

sleep(2000)

Text:="|<>*91$42.zzzzzzzzzzzzzzsDzzzzzsBzDzzzvlzYzzzvxxnTzzsBxnjzzvxwtjzzvxytzzzvxrtzzzvxrxzzzzzvxzzzzznzzzzzzvzzzzzzzzrzzzzzzrzzzzDzrzzzzDznzzzzDzszzzzDzszzzy7zzzzzw7zzrzzs7zzDzzk3zyDzzk3zsDzzk1zU7zzU1zU7zzU1z07zw03z01zw03z00Tw63z00zw43z00ty03z003q07zU07k2LzU0TkGTzcMzU0Tz8NrW1TzMHrXdTzN7bbtTzRbXzzzzzzzU"

ok:=FindText(&X:="wait", &Y:=3, 0,0,0,0,0,0,Text)  ; 等待3秒等图像出现

OutputDebug X ',' Y

; MouseClick("Left", X, Y, 2)
Send("{F1}")