iOS数据持久化小结
----------


持久化就是把数据保存在硬盘上而不是内存里，程序重启后数据不会消失。iOS中数据持久化方法有：**plist文件（属性列表）**、**UserDefaults**、**NSKeyedArchiver（归档）**、**SQLite3**、**CoreData**等，另外还有[**FMDB**](https://link.jianshu.com/?t=https://github.com/ccgus/fmdb)（用OC封装的SQLite库）、[realm](https://github.com/realm/realm-cocoa)（代替**SQLite3**和**CoreData**新的数据库）。



### plist
某些特定的数据类型，可以通过XML形式存储成`plist`文件。
这些数据类型都有`write(ToFile:)`方法，包括：
```swift
NSArray;
NSMutableArray;
NSDictionary;
NSMutableDictionary;
NSData;
NSMutableData;
NSString;
NSMutableString;
NSNumber;
NSDate;
```
示例代码：
```swift
// 获得路径
let fileManager = FileManager.default
let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
let fileName = path?.appendingPathComponent("test.plist")

// 存储。  其中atomically表示是否需要先写入一个辅助文件，再把辅助文件拷贝到目标文件地址。这是更安全的写入文件方法，一般都写true。
let arr: NSArray = [123, 34]
try? arr.write(toFile: (fileName?.path)!, atomically: true)

// 读取
let res = NSArray(contentsOfFile: (fileName?.path)!)

print((fileName?.path)!)
print(res)
```

### UserDefaults
```swift
// 获得UserDefaults文件
let userDefaults = UserDefaults.standard

// 向文件中写入内容
userDefaults.set("Andy", forKey: "name")
userDefaults.set("male", forKey: "sex")
userDefaults.set(100, forKey: "age")
// 立即保存
userDefaults.synchronize()
// 读取文件
let name = userDefaults.object(forKey: "name")
let sex = userDefaults.object(forKey: "sex")
let age = userDefaults.object(forKey: "age")

print(name, sex, age)
```
- 如果没有调用synchronize方法，系统会根据I/O情况不定时刻地保存到文件中。所以如果需要立即写入文件的就必须调用synchronize方法.
- `UserDefaults`适合存储少量的本地数据，比如要保存一个登陆界面的数据，用户名、密码之类的。
- 相对于`plist`文件，`UserDefaults`保存数据方便，不需要创建文件，读取文件。
- `UserDefaults `保存的数据也是`plist`类型文件，在目录`Library/Preferences/`里。

### NSKeyedArchiver（归档）
遵循了NSCoding协议的对象都可以通过NSKeyedArchiver实现序列化
- 实现NSCoding协议的两个方法
```
//解档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ([super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
```
- 归档后的对象存储和读取
```
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
```


### SQLite3 

1. 打开数据库并创建一个表
```
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
```
2. 插入数据
```
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
```
3. 读取数据
```
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
```

### CoreData
之前的笔记：[开始用Swift开发iOS 10 - 17 使用Core Data](http://andyron.com/2017/beginning-ios-swift-17.html)


