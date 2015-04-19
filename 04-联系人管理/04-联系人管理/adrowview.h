//
//  adrowview.h
//  04-联系人管理
//
//  Created by Ibokan on 15/4/5.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark 作为uiview的子 《类》,掌管对外承包添加xib视图控件业务,封装了内部属性和方法.
@interface adrowview : UIView
//返回万能指针比较客观
+ (id)creatOneRowContact:(NSString *)iconname andContactname:(NSString *)contactname;
//添加iboutlet ,使adrowview拥有xib控件,对外承包xib接口
@property (nonatomic,weak) IBOutlet UIButton * icon;
@property (nonatomic,weak) IBOutlet UILabel  * labletext;
@end
