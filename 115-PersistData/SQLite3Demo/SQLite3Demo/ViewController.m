//
//  ViewController.m
//  SQLite3Demo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()
{
    sqlite3 *_sqlite3;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self openDatabase];
    [self insertData];
    [self readData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  打开数据库并创建一个表
 */
- (void)openDatabase {
    
    //1.设置文件名
    NSString *filename = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.db"];
    
    //2.打开数据库文件，如果没有会自动创建一个文件
    NSInteger result = sqlite3_open(filename.UTF8String, &_sqlite3);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功！");
        
        //3.创建一个数据库表
        char *errmsg = NULL;
        
        sqlite3_exec(_sqlite3, "CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)", NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        } else {
            NSLog(@"创表成功！");
        }
        
    } else {
        NSLog(@"打开数据库失败！");
    }
}
/**
 *  往表中插入1000条数据
 */
- (void)insertData {
    
    NSString *nameStr;
    NSInteger age;
    for (NSInteger i = 0; i < 1000; i++) {
        nameStr = [NSString stringWithFormat:@"andy-%d", arc4random_uniform(10000)];
        age = arc4random_uniform(80) + 20;
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age) VALUES('%@', '%ld')", nameStr, age];
        
        char *errmsg = NULL;
        sqlite3_exec(_sqlite3, sql.UTF8String, NULL, NULL, &errmsg);
        if (errmsg) {
            NSLog(@"错误：%s", errmsg);
        }
    }
    
    NSLog(@"插入完毕！");
}
/**
 *  从表中读取数据
 */
- (void)readData {
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1000];
    char *sql = "select name, age from t_person;";
    sqlite3_stmt *stmt;

    NSInteger result = sqlite3_prepare_v2(_sqlite3, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {

            char *name = (char *)sqlite3_column_text(stmt, 0);
            NSInteger age = sqlite3_column_int(stmt, 1);
            NSLog(@"name: %s, age: %d", name, age);

      
        }
    }
    sqlite3_finalize(stmt);
}

@end
