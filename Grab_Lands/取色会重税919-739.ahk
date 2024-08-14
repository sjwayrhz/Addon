MButton:: {
    MouseMove(919, 739)
	
	targetColor := "0x2E2F2D" 
	x1 := 920
	y1 := 740
	x2 := 940
	y2 := 765
	tolerance := 10
	
    Loop x2 - x1 + 1
	{
		x := x1 + A_Index - 1
		Loop y2 - y1 + 1
		{
			y := y1 + A_Index - 1
			actualColor := PixelGetColor(925, 755)
			colorDiff := Abs(targetColor - actualColor)
			if (colorDiff <= tolerance) {
				MsgBox "颜色匹配成功"
				break  ; 
			}else{
				MsgBox "颜色匹配失败， color = " actualColor
				break  ; 
			}
		}        
    }
	
/*
    Click("left", 2)
    Sleep(10)

    Loop 50 {
        Click
        Sleep(10)
    }
*/
}