//
//  ViewController.h
//  04-联系人管理
//
//  Created by Ibokan on 15/4/3.
//  Copyright (c) 2015年 Ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)addContacts:(UIBarButtonItem *)sender;
- (IBAction)deleteContacts:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *disableDelete;
- (IBAction)rmrow:(id)sender;
@end

