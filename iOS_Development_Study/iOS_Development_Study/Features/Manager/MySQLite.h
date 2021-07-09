//
//  SQLite.h
//  iOS_Development_Study
//
//  Created by smbapp on 2021/7/7.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface MySQLite : NSObject

+ (MySQLite *)getMySQLiteInstance;

- (void)insertData:(NSString*)name gender:(NSInteger)gender;
- (NSDictionary *)sqlData;
- (void)updateData:(NSString *)name gender:(NSInteger)gender;
- (void)deleteData:(NSString *)name;
@end
