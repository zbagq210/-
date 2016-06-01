//
//  ViewController.h
//  数据库
//
//  Created by student  on 16/4/4.
//  Copyright © 2016年 zb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *Field;
@property (retain, nonatomic) IBOutlet UITextField *AgeTF;




- (IBAction)insertBtnClick:(UIButton *)sender;

- (IBAction)deleteBtnClick:(UIButton *)sender;
- (IBAction)updateBtnClick:(UIButton *)sender;

- (IBAction)selectBtnClick:(UIButton *)sender;



@end

