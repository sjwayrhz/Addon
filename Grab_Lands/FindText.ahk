#include <FindText.ahk>

MButton::
{
    ; 初始化 FindText 函数
    FindText.Init()

    ; 截取屏幕上 (926, 760) 位置的 5x5 像素区域
    result := FindText(926, 760, 2, 2, 5, 5, 0, 0, "**")

    ; 如果找到匹配的像素区域,则显示颜色信息
    if (result.Length() > 0)
    {
        ; 获取匹配区域的平均 RGB 颜色值
        avgColor := result[1].Av
        MsgBox "The color at (926, 760) is " avgColor
    }
    else
    {
        MsgBox "Color not found at (926, 760)"
    }
}