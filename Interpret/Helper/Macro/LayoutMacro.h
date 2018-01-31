
//
//  LayoutMacro.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#ifndef LayoutMacro_h
#define LayoutMacro_h

//获取屏幕 宽度、高度
#define Screen_width ([UIScreen mainScreen].bounds.size.width)
#define Screen_height ([UIScreen mainScreen].bounds.size.height)
#define Navigation_height  64


//取视图的X坐标
#define VIEW_X(view)        view.frame.origin.x
//取视图的Y坐标
#define VIEW_Y(view)        view.frame.origin.y
//取视图的宽
#define VIEW_WIDTH(view)    view.frame.size.width
//取视图的高
#define VIEW_HEIGHT(view)   view.frame.size.height
//取视图的最上面
#define VIEW_TOP(view)      view.frame.origin.y
//取视图的最左面
#define VIEW_LEFT(view)     view.frame.origin.x
//取视图的最下面
#define VIEW_BOTTOM(view)   view.frame.origin.y + view.frame.size.height
//取视图的最右面
#define VIEW_RIGHT(view)    view.frame.origin.x + view.frame.size.width
//视图中心位置X坐标
#define VIEW_CENTER_X(view)    view.center.x
//视图中心位置Y坐标
#define VIEW_CENTER_Y(view)    view.center.y

#endif /* LayoutMacro_h */
