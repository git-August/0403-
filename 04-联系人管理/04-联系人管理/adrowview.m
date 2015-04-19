//
//  adrowview.m
//  04-联系人管理
//
//  Created by Ibokan on 15/4/5.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import "adrowview.h"

@implementation adrowview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)creatOneRowContact:(NSString *)iconname andContactname:(NSString *)contactname{
    adrowview * view = [[NSBundle   mainBundle] loadNibNamed:@"Rowview" owner:nil options:nil][0];
    // 找到tag为1的子控件,这样实现耗费资源.
//    UIButton * icon = (UIButton *)[view viewWithTag:1];
    [view.icon setImage:[UIImage imageNamed:iconname] forState:UIControlStateNormal];
    //2.姓名
//    _labletext = (UILabel *)[view viewWithTag:2];
    view.labletext.text = contactname;
    return view;
}

@end
