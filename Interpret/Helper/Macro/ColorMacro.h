//
//  ColorMacro.h
//  金融微店
//
//  Created by 乔杰 on 2017/11/22.
//  Copyright © 2017年 乔杰. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

#pragma mark - 颜色处理

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define ColorFromHex(rgbValue)              [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//带有RGBA的颜色设置
#define COLOR(R, G, B, A)                   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B)                          COLOR(R,G,B,1.0f)


#define Current_theme_identifire  [[ThemeMannager defaultManager] currentThemeIdentifier]

#define Clear_color  [UIColor clearColor]
#define White_color  [UIColor whiteColor]
#define Random_color [UIColor colorWithRed: arc4random()%256/255.0 green: arc4random()%256/255.0 blue: arc4random()%256/255.0 alpha: 1.0]


#define Navigation_bar_tint_color               White_color
#define Navigation_bar_title_color              ColorFromHex(0x404040)
#define Navigation_bar_itemtext_color           ColorFromHex(0x808080)

#define Tabbar_bar_tint_color                   White_color
#define Tabbar_selected_text_color              ColorFromHex(0x404040)
#define Tabbar_unselected_text_color            ColorFromHex(0x909090)

#define Main_text_color                         ColorFromHex(0x404040)
#define Main_text_color_gray                    ColorFromHex(0x808080)
#define Main_text_color_light_gray              ColorFromHex(0x909090)
#define Seperator_line_color                    ColorFromHex(0xDCDCDC)

#define Main_color                              ColorFromHex(0xFF7F00)
#define Main_background_color                   ColorFromHex(0xF5F5F5)

#define Button_selected_back_color              ColorFromHex(0xFF7F00)
#define Button_selected_text_color              White_color
#define Button_unselected_back_color            ColorFromHex(0xDCDCDC)
#define Button_unselected_text_color            ColorFromHex(0x404040)


#endif /* ColorMacro_h */
