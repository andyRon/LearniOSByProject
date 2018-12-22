//
//  ViewController.m
//  NSKeyedArchiverOCDemo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self save];
    [self get];
}

- (void)save {
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    
    Person *person = [[Person alloc] init];
    person.sex = @"male";
    person.name = @"Andy";
    person.age = 100;
    
    [NSKeyedArchiver archiveRootObject:person toFile:file];
}

- (void)get {
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (person) {
        NSLog(@"name: %@, sex: %@, age: %ld", person.name, person.sex, (long)person.age);
    }

}



@end
