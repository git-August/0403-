//
//  ViewController.m
//  04-联系人管理
//
//  Created by Ibokan on 15/4/3.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import "ViewController.h"
#import "picture.h"
#import "adrowview.h"
#define rowH 50
#define iconW 50
#define iconNum 9
#define contactNum 5
#define labletext_tagvalue 99
#define deleteX 250
@interface ViewController () {
    NSArray * _labletext;//1.要加大括号2.指针数组3.不赋值
    picture * _pic;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _labletext = @[@"孙大圣",@"猪八戒",@"沙和尚",@"白龙马",@"唐僧"];//初始化指针数组

    _disableDelete.enabled = false;
    _pic = [[picture alloc] init];//类有,需要实例化才能使用.
    UIView * picview = [[NSBundle mainBundle] loadNibNamed:@"show" owner:_pic options:nil][0];
    picview.center = CGPointMake(160, 44);
    
//    UIImageView * imgview = [[UIImageView alloc] initWithImage:_pic.picimg];
//    imgview.frame = CGRectMake(0, 0, 320, 568);
////    [self.view addSubview:imgview];
    [self.view addSubview:picview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addContacts:(UIBarButtonItem *)sender {
//    NSLog(@"%@",self.view.subviews[0]);//拖动toolbar控件到controller即完成controller包含toolbar对象

    //在内存中创建出来
    UIView * contactview = [self creatOneRowContact];
    //动画效果
    //0.上一行得到下一行
    UIView * lastrow = self.view.subviews.lastObject;
    CGFloat rowY = lastrow.frame.origin.y + lastrow.frame.size.height + 1;
    contactview.alpha = 0;
    contactview.frame = CGRectMake(320, rowY, 320, rowH);
    [UIView animateWithDuration:0.6 animations:^{
        contactview.alpha = 1;
        contactview.frame = CGRectMake(0, rowY, 320, rowH);
    }];
    //搬移到视图,实现效果
    [self.view addSubview:contactview];
    
    _disableDelete.enabled = YES;
}
#pragma mark 控制器创建了一行联系人,抽取为业务逻辑方法
- (UIView *)creatOneRowContact{
#pragma mark 使用代码添加控件
    /*//1.内存添加父控件
    UIView * contactview = [[UIView alloc] init];
    contactview.backgroundColor = [UIColor redColor];
    
    
    //2.内存添加联系人姓名
    UILabel * lable = [[UILabel alloc] init];
    lable.text = _labletext[arc4random_uniform(contactNum)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame = CGRectMake(0, 0, 320, rowH);
    lable.tag = labletext_tagvalue;
    [contactview addSubview:lable];
    
    //3.内存添加联系人头像
//    UIButton * icon = [[UIButton alloc] init];
    UIButton * icon = [UIButton buttonWithType:UIButtonTypeCustom];
    icon.backgroundColor = [UIColor greenColor];
    NSString * imgname = [NSString stringWithFormat:@"01%d.png",arc4random_uniform(iconNum)];
    UIImage * img = [UIImage imageNamed:imgname];
    //backgroud随宽高变化,而image特立
    [icon setImage:img forState:UIControlStateNormal];
    icon.frame = CGRectMake(0, 0, iconW, rowH);
    //3.1.单击头像得到联系人姓名

    [icon addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
    [contactview addSubview:icon];
    
    //4.内存添加删除按钮
    UIButton * deletecontactview = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deletecontactview.frame = CGRectMake(deleteX, 0, iconW, iconW);
    [deletecontactview setTitle:@"删除" forState:UIControlStateNormal];
    [deletecontactview setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deletecontactview addTarget:self action:@selector(rmrow:) forControlEvents:UIControlEventTouchUpInside];
    [contactview addSubview:deletecontactview];
    return contactview;*/

#pragma mark xib实现添加控件,藕合性高,
    /**///1.头像
    NSArray * views = [[NSBundle   mainBundle] loadNibNamed:@"Rowview" owner:self options:nil];
//    NSLog(@"%@",views);
    //把xib文件组合为数组.从xib中取出控件
    UIButton * icon = (UIButton *)[views[0] viewWithTag:1];
    NSString * imgname = [NSString stringWithFormat:@"01%d.png",arc4random_uniform(9)];
    [icon setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    //2.姓名
    UILabel * labletext = (UILabel *)[views[0] viewWithTag:2];
    labletext.text = _labletext[arc4random_uniform(5)];
    //3.删除
    //3.1tag操作－－删除方法一
//    UIButton * delete = (UIButton *)[views[0] viewWithTag:3];
//    [delete addTarget:self action:@selector(rmrow:) forControlEvents:UIControlEventTouchUpInside];
    //3.2拖线操作,查找子控件数组里tag为某值的子控件,效率低.－－删除方法二:1⃣️viewcontroller拥有xib文件;2⃣️xib文件确认file's owner为viewcontroller3⃣️viewcontroller具备添加xib中的控件为自己的子控件的能力.
    return views[0];
#pragma mark 代理adrowview的类方法使V和C的分离,藕合性低,代码复用性高.
//    NSString * imgname = [NSString stringWithFormat:@"01%d.png",arc4random_uniform(9)];
//    NSString * contactname = _labletext[arc4random_uniform(5)];
//    UIView * view = [adrowview creatOneRowContact:imgname andContactname:contactname];
    
//    return view;

}
- (IBAction)deleteContacts:(UIBarButtonItem *)sender {
    UIView * currentview = self.view.subviews.lastObject;
    CGFloat  rowY = currentview.frame.origin.y;
    [UIView animateWithDuration:0.6 animations:^{
        currentview.frame = CGRectMake(320, rowY, 320, rowH);
    currentview.alpha = 0;
    } completion:^(BOOL finished) {
        [currentview removeFromSuperview];
        _disableDelete.enabled = self.view.subviews.count > 1;
    }];
}
//SEL:@selector传入参数
- (void)iconClick:(id)sender{
    UIView * view = [[sender superview] viewWithTag:labletext_tagvalue];
    UILabel * labletxt = (UILabel *)view;
    NSLog(@"%@",labletxt.text);
}

- (void)rmrow:(id)sender{
    UIView * view = [sender superview];
    CGFloat rowY = view.frame.origin.y;
    [UIView animateWithDuration:0.6 animations:^{//当地扩展代码,然后添加block
        view.alpha = 0;
        view.frame = CGRectMake(320, rowY, 320, rowH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            NSArray * views = self.view.subviews;
            NSUInteger index = [views indexOfObject:view];//数组可以取到数组中的某一个元素的索引!!!
            [view removeFromSuperview];
            for (NSUInteger i = index; i < views.count; i++) {
                UIView * currentview = views[i];
                currentview.frame = CGRectMake(currentview.frame.origin.x, currentview.frame.origin.y - rowH - 1, 320, rowH);
            }
            _disableDelete.enabled = self.view.subviews.count > 1;
        }];
    }];
}
@end
