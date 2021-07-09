//
//  SQLite.m
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/7.
//

#import "MySQLite.h"

@interface MySQLite ()

@property (assign, nonatomic) sqlite3 *studyDatabase;

@end

static MySQLite *mySQL = nil;

@implementation MySQLite

+ (MySQLite *)getMySQLiteInstance {
//    dispatch_once_t once;
//    dispatch_once(&once, ^{
    if (mySQL == nil) {
        mySQL = [[self alloc] init];
        [mySQL createDataBase];
    }
//    });
    return mySQL;
}



//生成路径
+(NSString *)path {
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentPath = [documentArr firstObject];
    // crylown.db 为数据库的名字
    NSString *path = [NSString stringWithFormat:@"%@/student.sqlite",documentPath];
    NSLog(@"位置path == %@",path);
    return path;
}

//创建/打开数据库
- (void)createDataBase {
    int databaseResult = sqlite3_open([[MySQLite path] UTF8String], &_studyDatabase);

    if (databaseResult == SQLITE_OK) {
        [self createForm];
    }else{
        NSLog(@"创建／打开数据库失败,%d",databaseResult);
    }
}

//创建表
-(void)createForm{
    char *error = NULL;
        
    //建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
    const char *createSQL = "CREATE TABLE IF NOT EXISTS info (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, gender INTEGER)";
    /* 执行sql语句
        第1个参数：数据库对象
        第2个参数：sql语句
        第3个参数：查询时候用到的一个结果集闭包
        第4个参数：用不到
        第5个参数：错误信息
    */
    int tableResult = sqlite3_exec(self.studyDatabase, createSQL, NULL, NULL, &error);
        
    if (tableResult == SQLITE_OK) {
        NSLog(@"创建成功");
    }else{
        NSLog(@"创建表失败:%s",error);
    }
}

// 插入数据
- (void)insertData:(NSString *)title gender:(NSInteger)gender {
        // 拼接 sql 语句
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO info (title, gender) VALUES ('%@', %ld);", title, gender];
        // 执行 sql 语句
        char *errMsg = NULL;
        int result = sqlite3_exec(self.studyDatabase, sql.UTF8String, NULL, NULL, &errMsg);
        
        if (result == SQLITE_OK) {
            NSLog(@"插入数据成功 - %@", title);
        } else {
            NSLog(@"插入数据失败 - %s",errMsg);
        }
}

// 查询操作
- (NSDictionary *)sqlData {
    // sql语句
    const char *sql="SELECT title, gender FROM info;";
    sqlite3_stmt *stmt = nil;
    /*
        第1个参数：一个已经打开的数据库对象
        第2个参数：sql语句
        第3个参数：参数2中取出多少字节的长度，-1 自动计算，\0停止取出
        第4个参数：准备语句
        第5个参数：通过参数3，取出参数2的长度字节之后，剩下的字符串
    */
    // 进行查询前的准备工作
    if (sqlite3_prepare_v2(self.studyDatabase, sql, -1, &stmt, NULL) == SQLITE_OK) {   // sql语句没有问题
        NSLog(@"sql语句没有问题");
        
        NSMutableArray *nameArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *genderArray = [NSMutableArray arrayWithCapacity:0];
        // 每调用一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {  // 找到一条记录
            // 取出数据
            const char *title = (const char *)sqlite3_column_text(stmt, 0);   // 取出第1列字段的值
            int gender = sqlite3_column_int(stmt, 1);  // 取出第2列字段的值
            NSString *nameString = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
            NSString *genderString = gender ? @"Male" : @"Female";
            [nameArray addObject:nameString];
            [genderArray addObject:genderString];
        }
        NSDictionary *returnDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: nameArray, @"nameArray", genderArray, @"genderArray", nil];
        return returnDictionary;
    } else {
        NSLog(@"查询语句有问题");
        return nil;
    }
}

//修改数据
- (void)updateData:(NSString *)title gender:(NSInteger)gender {
    //其实Sqlite的数据插入，修改，删除执行的方法都是一样的只是执行的sql语句不一样，想知道sql的更多语句操作自行百度了，比较多这里就不讲解了，只介绍一些基本的操作方法。
    //sqlite3数据(把年龄大于60的学生名字全部改成‘哈哈’)
    // 拼接 sql 语句
    NSString *sql = [NSString stringWithFormat:@"UPDATE info SET gender = %ld WHERE title = '%@';", gender, title];
    char *errorMesg = NULL;
    int result = sqlite3_exec(self.studyDatabase, sql.UTF8String, NULL, NULL, &errorMesg);
    if (result == SQLITE_OK) {
        NSLog(@"更改成功");
    } else {
        NSLog(@"更改失败");
    }
    //然后执行查询语句就能看到更改后的效果了
}

//删除数据
- (void)deleteData:(NSString *)title {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM info WHERE title = '%@'", title];
    char *errorMesg = NULL;
    int result = sqlite3_exec(self.studyDatabase, sql.UTF8String, NULL, NULL, &errorMesg);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}


@end
