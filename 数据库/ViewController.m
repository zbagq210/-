//
//  ViewController.m
//  数据库
//
//  Created by student  on 16/4/4.
//  Copyright © 2016年 zb. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()
{
    FMDatabase *__db;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1首先要创建一个数据库
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/student.sqlite"];
    //输出沙盒路径
    NSLog(@"沙盒路径:--->%@",NSHomeDirectory());
    
    //2创建数据库对象
    __db  = [FMDatabase databaseWithPath:path];
    [__db retain];
    
    //3 创建一个表
    if ([__db open]) {
        [__db retain];
        NSString *createSql = [NSString stringWithFormat: @"create table if not exists student(id integer primary key autoincrement unique,name text not null,age int)"];
        //让db执行SQL语句
        BOOL isSuccess = [__db executeUpdate:createSql];
        if (isSuccess) {
            NSLog(@"执行SQL语句成功");
        } else {
            NSLog(@"执行SQL语句失败");
        }
        NSLog(@"打开数据库成功");
    }
}

- (void)dealloc {
    [_Field release];
    
    [_AgeTF release];
    [super dealloc];
}

- (IBAction)insertBtnClick:(UIButton *)sender {
    if (self.Field.text.length>0) {
        NSString *insertSql= [NSString stringWithFormat:@"insert into student(name,age) values('%@','%@')",self.Field.text,self.AgeTF.text];
        BOOL isSuccess = [__db executeUpdate:insertSql];
        if (isSuccess) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }
}

- (IBAction)updateBtnClick:(UIButton *)sender {
    
    if (self.Field.text.length>0) {
        NSString *updateSql = [NSString stringWithFormat:@"update student set name = '%@',age='%@'",self.Field.text,self.AgeTF.text];
        
        BOOL isSuccess = [__db executeUpdate:updateSql];
        if (isSuccess) {
            NSLog(@"修改成功");
        } else {
            NSLog(@"修改失败");
        }
    }
}
- (IBAction)deleteBtnClick:(UIButton *)sender
{
    if (self.Field.text.length>0)
    {
        NSString *deleteSql= [NSString stringWithFormat:@"delete from student where name = '%@'",self.Field.text];
        BOOL isSuccess = [__db executeUpdate:deleteSql];
        
        if (isSuccess)
        {
            NSLog(@"删除成功");
        } else
        {
            NSLog(@"删除失败");
        }
    }
}



- (IBAction)selectBtnClick:(UIButton *)sender {
    if (self.Field.text.length>0) {
        NSString *selectSql = [NSString stringWithFormat:@"select*from student where name = '%@'",self.Field.text];
        
        FMResultSet *set = [__db executeQuery:selectSql];
        while ([set next])
        {
            NSString *name  = [set stringForColumn:@"name"];
            NSInteger student_id = [set intForColumn:@"id"];
            
            NSLog(@"--%@--%ld--",name,student_id);
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
