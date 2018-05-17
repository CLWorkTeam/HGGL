//
//  TKDownLoadDataBase.m
//  泰行销
//
//  Created by 陈磊 on 2018/2/5.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import "TKDownLoadDataBase.h"
#import "TKDownLoadDataBaseModel.h"
static TKDownLoadDataBase *dbHandler = nil;
@implementation TKDownLoadDataBase
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        dbHandler = [[self alloc]init];
        
    });
    return dbHandler;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [TKDownLoadDataBase shareInstance];
}
-(BOOL)openDB
{
    //打开数据库：读取本地的数据库文件，让一个指针指向他，方便后续方法的访问。
    
    //在沙盒中创建一个db文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    NSString *path = [docPath stringByAppendingPathComponent:@"course.db"];
    
    //参数1.文件路径（如果路径下没有文件，会自动创建一个，如果有，直接读取）
    //参数2.数据库指针的地址
    int result = sqlite3_open([path UTF8String], &dbPoint);
    
    return [self judgeResult:result withTitle:@"打开数据库"];
}
-(BOOL)closeDB
{
    //关闭数据库：让数据库指针不在指向本地数据库
    int result = sqlite3_close(dbPoint);
    
    
    return [self judgeResult:result withTitle:@"关闭数据库"];
    
}
//封装一个方法，用来判断数据库的执行结果
-(BOOL)judgeResult:(int)result withTitle:(NSString *)title
{
    if (result == SQLITE_OK) {
        HGLog(@"%@成功",title);
        return  YES;
        
    }
    else{
        HGLog(@"%@失败，失败原因：%d",title,result);
        return  NO;
    }
    
}
//创建下载表
-(BOOL)createDownLoadTable
{
    NSString *sql = [NSString stringWithFormat:@"create table IF NOT EXISTS downLoadTable (imageUrl text,intro text,titleStr text,liveId text,url text,totalLength text,localUrl text, keyBoard integer primary key AUTOINCREMENT)"];
    
    //参数1：数据库指针
    //参数2：sql语句
    int result = sqlite3_exec(dbPoint, [sql UTF8String], NULL, NULL, NULL);
    return [self judgeResult:result withTitle:@"创建下载表"];
}
//插入一条数据
-(BOOL)downLoadInsertDataBaseModel:(TKDownLoadDataBaseModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO downLoadTable(imageUrl,intro,titleStr,liveId,url,totalLength,localUrl)values('%@', '%@','%@','%@','%@', '%@','%@')",model.imageUrl,model.intro?model.intro:NULL,model.titleStr,model.liveId,model.url,model.totalLength,model.localUrl];
    
    
    int result = sqlite3_exec(dbPoint, [sql UTF8String], NULL, NULL, NULL);
    
    return  [self judgeResult:result withTitle:@"下载添加一条数据"];
}
////删除一条数据
-(BOOL)downLoadDeleteDataBaseModelWithurl:(NSString *)url
{
    char *error;
    //删除一条数据
    TKDownLoadDataBaseModel *model = [self  haveDownLoad:url];
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filepath = [document stringByAppendingPathComponent:model.localUrl];
    if ((!model.localUrl)||([model.localUrl isEqualToString:@""])) {
        
    }else
    {
        if ([mgr fileExistsAtPath:filepath]) {
            HGLog(@"%@",filepath);
            [mgr  removeItemAtPath:filepath error:nil];
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"delete from downLoadTable where url = '%@'", url];
    int result = sqlite3_exec(dbPoint, [sql UTF8String], NULL, NULL, &error);
    if (result == SQLITE_OK) {
        //        //nslog(@"删除成功");
    }
    return [self judgeResult:result withTitle:@"下载表删除"];
}
//更新一条数据
-(BOOL)downLoadUpdateDataBaseModel:(TKDownLoadDataBaseModel *)model withUrl:(NSString *)url
{
    NSString *sql = [NSString stringWithFormat:@"update downLoadTable set imageUrl = '%@', intro = '%@',titleStr = '%@', liveId = '%@',url ='%@',totalLength = '%@',localUrl = '%@'  where url = '%@'", model.imageUrl,model.intro?model.intro:NULL,model.titleStr,model.liveId,model.url,model.totalLength,model.localUrl,model.url];
    
    
    int result = sqlite3_exec(dbPoint, [sql UTF8String], NULL, NULL, NULL);
    
    //NSLog(@"%@", sql);
    
    return [self judgeResult:result withTitle:@"下载更改数据"];
}
//查询相对应的数据
-(TKDownLoadDataBaseModel *)downLoadSelectWithUrl:(NSString *)url
{
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"select *from downLoadTable where url = '%@'",url];
    int result = sqlite3_prepare(dbPoint, [sql UTF8String], -1, &stmt, nil);
    //    NSMutableArray *tempArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        //如果sql语句执行成功，就开始提取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //如果替身中保存有数据，就会一直执行循环体，直到便利完所有的数据为止
            
            TKDownLoadDataBaseModel *model = [[TKDownLoadDataBaseModel alloc] init];
            
            //读取某一列的数据信息
            //参数1.替身
            //参数2.列的顺序
            const unsigned char *imageUrlChar = sqlite3_column_text(stmt, 0);
            const unsigned char *introChar = sqlite3_column_text(stmt, 1);
            const unsigned char *titleStrChar = sqlite3_column_text(stmt, 2);
            const unsigned char *liveIdChar = sqlite3_column_text(stmt, 3);
            const unsigned char *urlChar = sqlite3_column_text(stmt, 4);
            const unsigned char *totalLengthChar = sqlite3_column_text(stmt, 5);
            const unsigned char *localUrlChar = sqlite3_column_text(stmt, 6);
            int keyBoard = sqlite3_column_int(stmt, 7);
            //将C的字符串转化为OC的字符串
            
            
            
            NSString * imageUrl;
            NSString * intro;
            NSString * titleStr;
            NSString * liveId;
            NSString * url;
            NSString * totalLength;
            NSString * localUrl;
            
            if (strcmp((const char *)imageUrlChar, "(null)") == 0) {
                imageUrl = nil;
            }else
            {
                imageUrl = [NSString stringWithUTF8String:(const char *)imageUrlChar];
            }
            if (strcmp((const char *)introChar, "(null)") == 0) {
                intro = nil;
            }else
            {
                intro = [NSString stringWithUTF8String:(const char *)introChar];
            }
            
            if (strcmp((const char *)titleStrChar, "(null)") == 0) {
                titleStr = nil;
            }else
            {
                titleStr = [NSString stringWithUTF8String:(const char *)titleStrChar];
            }
            
            if (strcmp((const char *)liveIdChar, "(null)") == 0) {
                liveId = nil;
            }else{
                liveId = [NSString stringWithUTF8String:(const char *)liveIdChar];
            }
            if (strcmp((const char *)localUrlChar, "(null)") == 0) {
                localUrl = nil;
            }else{
                localUrl = [NSString stringWithUTF8String:(const char *)localUrlChar];
            }
            if (strcmp((const char *)totalLengthChar, "(null)") == 0) {
                totalLength = nil;
            }else{
                totalLength = [NSString stringWithUTF8String:(const char *)totalLengthChar];
            }
            
            if (strcmp((const char *)urlChar, "(null)") == 0) {
                url = nil;
            }else{
                url = [NSString stringWithUTF8String:(const char *)urlChar];
            }
            
            
            model.keyBoard = keyBoard;
            model.imageUrl = imageUrl;
            model.intro = intro;
            model.titleStr = titleStr;
            model.liveId = liveId;
            model.localUrl = localUrl;
            model.totalLength = totalLength;
            model.url = url;
            sqlite3_finalize(stmt);
            return model;
        }
    }
    //将替身的保存数据库操作写入本地的源数据库
    sqlite3_finalize(stmt);
    return nil;
}
//判断是否已经下载过
-(TKDownLoadDataBaseModel *)haveDownLoad:(NSString *)url
{
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"select *from downLoadTable where url = '%@'",url];
    int result = sqlite3_prepare(dbPoint, [sql UTF8String], -1, &stmt, nil);
    //    NSMutableArray *tempArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        //如果sql语句执行成功，就开始提取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //如果替身中保存有数据，就会一直执行循环体，直到便利完所有的数据为止
            
            TKDownLoadDataBaseModel *model = [[TKDownLoadDataBaseModel alloc] init];
            
            //读取某一列的数据信息
            //参数1.替身
            //参数2.列的顺序
            
            
            const unsigned char *imageUrlChar = sqlite3_column_text(stmt, 0);
            const unsigned char *introChar = sqlite3_column_text(stmt, 1);
            const unsigned char *titleStrChar = sqlite3_column_text(stmt, 2);
            const unsigned char *liveIdChar = sqlite3_column_text(stmt, 3);
            const unsigned char *urlChar = sqlite3_column_text(stmt, 4);
            const unsigned char *totalLengthChar = sqlite3_column_text(stmt, 5);
            const unsigned char *localUrlChar = sqlite3_column_text(stmt, 6);
            int keyBoard = sqlite3_column_int(stmt, 7);
            
            
            
            //将C的字符串转化为OC的字符串
            
            
            
            NSString * imageUrl;
            NSString * intro;
            NSString * titleStr;
            NSString * liveId;
            NSString * url;
            NSString * totalLength;
            NSString * localUrl;
            
            if (strcmp((const char *)imageUrlChar, "(null)") == 0) {
                imageUrl = nil;
            }else
            {
                imageUrl = [NSString stringWithUTF8String:(const char *)imageUrlChar];
            }
            if (strcmp((const char *)introChar, "(null)") == 0) {
                intro = nil;
            }else
            {
                intro = [NSString stringWithUTF8String:(const char *)introChar];
            }
            
            if (strcmp((const char *)titleStrChar, "(null)") == 0) {
                titleStr = nil;
            }else
            {
                titleStr = [NSString stringWithUTF8String:(const char *)titleStrChar];
            }
            
            if (strcmp((const char *)liveIdChar, "(null)") == 0) {
                liveId = nil;
            }else{
                liveId = [NSString stringWithUTF8String:(const char *)liveIdChar];
            }
            if (strcmp((const char *)localUrlChar, "(null)") == 0) {
                localUrl = nil;
            }else{
                localUrl = [NSString stringWithUTF8String:(const char *)localUrlChar];
            }
            if (strcmp((const char *)totalLengthChar, "(null)") == 0) {
                totalLength = nil;
            }else{
                totalLength = [NSString stringWithUTF8String:(const char *)totalLengthChar];
            }
            
            if (strcmp((const char *)urlChar, "(null)") == 0) {
                url = nil;
            }else{
                url = [NSString stringWithUTF8String:(const char *)urlChar];
            }
            
            
            model.keyBoard = keyBoard;
            model.imageUrl = imageUrl;
            model.intro = intro;
            model.titleStr = titleStr;
            model.liveId = liveId;
            model.localUrl = localUrl;
            model.totalLength = totalLength;
            model.url = url;
            
            
            sqlite3_finalize(stmt);
            return model;
        }
    }
    //将替身的保存数据库操作写入本地的源数据库
    sqlite3_finalize(stmt);
    return nil;
}
-(NSMutableArray *)downingItems
{
    sqlite3_stmt *stmt = nil;
    
    //2.准备一个sql语句并执行
    
    NSString *sql = [NSString stringWithFormat:@"select *from downLoadTable"];
    //参数1。数据库指针
    //参数2.sql语句
    //参数3.限制sql语句长度 （-1为不限制）
    //参数4.替身的指针地址
    //作用：执行sql语句，并将结果保存在替身里
    int result = sqlite3_prepare(dbPoint, [sql UTF8String], -1, &stmt, nil);
    //提前创建好一个空数组
    NSMutableArray *tempArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        //如果sql语句执行成功，就开始提取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //如果替身中保存有数据，就会一直执行循环体，直到便利完所有的数据为止
            
            TKDownLoadDataBaseModel *model = [[TKDownLoadDataBaseModel alloc] init];
            
            //读取某一列的数据信息
            //参数1.替身
            //参数2.列的顺序
            
            
            const unsigned char *imageUrlChar = sqlite3_column_text(stmt, 0);
            const unsigned char *introChar = sqlite3_column_text(stmt, 1);
            const unsigned char *titleStrChar = sqlite3_column_text(stmt, 2);
            const unsigned char *liveIdChar = sqlite3_column_text(stmt, 3);
            const unsigned char *urlChar = sqlite3_column_text(stmt, 4);
            const unsigned char *totalLengthChar = sqlite3_column_text(stmt, 5);
            const unsigned char *localUrlChar = sqlite3_column_text(stmt, 6);
            int keyBoard = sqlite3_column_int(stmt, 7);
            
            
            
            //将C的字符串转化为OC的字符串
            
            
            
            NSString * imageUrl;
            NSString * intro;
            NSString * titleStr;
            NSString * liveId;
            NSString * url;
            NSString * totalLength;
            NSString * localUrl;
            
            if (strcmp((const char *)imageUrlChar, "(null)") == 0) {
                imageUrl = nil;
            }else
            {
                imageUrl = [NSString stringWithUTF8String:(const char *)imageUrlChar];
            }
            if (strcmp((const char *)introChar, "(null)") == 0) {
                intro = nil;
            }else
            {
                intro = [NSString stringWithUTF8String:(const char *)introChar];
            }
            
            if (strcmp((const char *)titleStrChar, "(null)") == 0) {
                titleStr = nil;
            }else
            {
                titleStr = [NSString stringWithUTF8String:(const char *)titleStrChar];
            }
            
            if (strcmp((const char *)liveIdChar, "(null)") == 0) {
                liveId = nil;
            }else{
                liveId = [NSString stringWithUTF8String:(const char *)liveIdChar];
            }
            if (strcmp((const char *)localUrlChar, "(null)") == 0) {
                localUrl = nil;
            }else{
                localUrl = [NSString stringWithUTF8String:(const char *)localUrlChar];
            }
            if (strcmp((const char *)totalLengthChar, "(null)") == 0) {
                totalLength = nil;
            }else{
                totalLength = [NSString stringWithUTF8String:(const char *)totalLengthChar];
            }
            
            if (strcmp((const char *)urlChar, "(null)") == 0) {
                url = nil;
            }else{
                url = [NSString stringWithUTF8String:(const char *)urlChar];
            }
            
            
            model.keyBoard = keyBoard;
            model.imageUrl = imageUrl;
            model.intro = intro;
            model.titleStr = titleStr;
            model.liveId = liveId;
            model.localUrl = localUrl;
            model.totalLength = totalLength;
            model.url = url;
            NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            if (model.localUrl) {
                NSFileManager *mgr = [NSFileManager defaultManager];
                if ([mgr fileExistsAtPath:[document stringByAppendingPathComponent:model.localUrl]]) {
                    NSDictionary *att = [mgr attributesOfItemAtPath:[document stringByAppendingPathComponent:model.localUrl]  error:nil];
                    
                    if (att.fileSize < [model.totalLength longLongValue]) {
                        [tempArr addObject:model];
                    }
                    
                }else
                {
                    
                    [tempArr addObject:model];
                    
                }
                
                
            }else
            {
                [tempArr addObject:model];
            }
        }
    }
    //将替身的保存数据库操作写入本地的源数据库
    sqlite3_finalize(stmt);
    return tempArr;
}
-(NSMutableArray *)downedItems
{
    sqlite3_stmt *stmt = nil;
    
    //2.准备一个sql语句并执行
    
    NSString *sql = [NSString stringWithFormat:@"select *from downLoadTable"];
    //参数1。数据库指针
    //参数2.sql语句
    //参数3.限制sql语句长度 （-1为不限制）
    //参数4.替身的指针地址
    //作用：执行sql语句，并将结果保存在替身里
    int result = sqlite3_prepare(dbPoint, [sql UTF8String], -1, &stmt, nil);
    //提前创建好一个空数组
    NSMutableArray *tempArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        //如果sql语句执行成功，就开始提取数据
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //如果替身中保存有数据，就会一直执行循环体，直到便利完所有的数据为止
            
            TKDownLoadDataBaseModel *model = [[TKDownLoadDataBaseModel alloc] init];
            
            //读取某一列的数据信息
            //参数1.替身
            //参数2.列的顺序
            
            
            const unsigned char *imageUrlChar = sqlite3_column_text(stmt, 0);
            const unsigned char *introChar = sqlite3_column_text(stmt, 1);
            const unsigned char *titleStrChar = sqlite3_column_text(stmt, 2);
            const unsigned char *liveIdChar = sqlite3_column_text(stmt, 3);
            const unsigned char *urlChar = sqlite3_column_text(stmt, 4);
            const unsigned char *totalLengthChar = sqlite3_column_text(stmt, 5);
            const unsigned char *localUrlChar = sqlite3_column_text(stmt, 6);
            int keyBoard = sqlite3_column_int(stmt, 7);
            
            
            
            //将C的字符串转化为OC的字符串
            
            
            
            NSString * imageUrl;
            NSString * intro;
            NSString * titleStr;
            NSString * liveId;
            NSString * url;
            NSString * totalLength;
            NSString * localUrl;
            
            if (strcmp((const char *)imageUrlChar, "(null)") == 0) {
                imageUrl = nil;
            }else
            {
                imageUrl = [NSString stringWithUTF8String:(const char *)imageUrlChar];
            }
            if (strcmp((const char *)introChar, "(null)") == 0) {
                intro = nil;
            }else
            {
                intro = [NSString stringWithUTF8String:(const char *)introChar];
            }
            
            if (strcmp((const char *)titleStrChar, "(null)") == 0) {
                titleStr = nil;
            }else
            {
                titleStr = [NSString stringWithUTF8String:(const char *)titleStrChar];
            }
            
            if (strcmp((const char *)liveIdChar, "(null)") == 0) {
                liveId = nil;
            }else{
                liveId = [NSString stringWithUTF8String:(const char *)liveIdChar];
            }
            if (strcmp((const char *)localUrlChar, "(null)") == 0) {
                localUrl = nil;
            }else{
                localUrl = [NSString stringWithUTF8String:(const char *)localUrlChar];
            }
            if (strcmp((const char *)totalLengthChar, "(null)") == 0) {
                totalLength = nil;
            }else{
                totalLength = [NSString stringWithUTF8String:(const char *)totalLengthChar];
            }
            
            if (strcmp((const char *)urlChar, "(null)") == 0) {
                url = nil;
            }else{
                url = [NSString stringWithUTF8String:(const char *)urlChar];
            }
            
            
            model.keyBoard = keyBoard;
            model.imageUrl = imageUrl;
            model.intro = intro;
            model.titleStr = titleStr;
            model.liveId = liveId;
            model.localUrl = localUrl;
            model.totalLength = totalLength;
            model.url = url;
            NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            if (model.localUrl) {
                NSFileManager *mgr = [NSFileManager defaultManager];
                if ([mgr fileExistsAtPath:[document stringByAppendingPathComponent:model.localUrl]]) {
                    NSDictionary *att = [mgr attributesOfItemAtPath:[document stringByAppendingPathComponent:model.localUrl]  error:nil];
                    
                    if (att.fileSize >= [model.totalLength longLongValue]) {
                        [tempArr addObject:model];
                    }
                    
                }
                
                
            }
        }
    }
    //将替身的保存数据库操作写入本地的源数据库
    sqlite3_finalize(stmt);
    return tempArr;
}
@end
