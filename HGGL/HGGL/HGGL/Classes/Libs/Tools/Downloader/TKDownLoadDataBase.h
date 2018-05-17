//
//  TKDownLoadDataBase.h
//  泰行销
//
//  Created by 陈磊 on 2018/2/5.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TKDownLoadDataBaseModel.h"
@interface TKDownLoadDataBase : NSObject
{
    //声明一个sqlite3类型的指针，用来指向本地的数据库文件
    sqlite3 *dbPoint;
}
//单例：一个应用程序执行期间，只会产生一个对象
//单例方法：1.加号方法 2.方法名是shareInstance 3.返回值是自己类的对象
+(instancetype)shareInstance;

/**
 打开数据库

 @return 打开数据库是否成功
 */
-(BOOL)openDB;

/**
 关闭数据库

 @return 关闭数据库是否成功
 */
-(BOOL)closeDB;

//创建表
-(BOOL)createDownLoadTable;
//插入一条数据
-(BOOL)downLoadInsertDataBaseModel:(TKDownLoadDataBaseModel *)model;
////删除一条数据
-(BOOL)downLoadDeleteDataBaseModelWithurl:(NSString *)url;
//更新一条数据
-(BOOL)downLoadUpdateDataBaseModel:(TKDownLoadDataBaseModel *)model withUrl:(NSString *)url;
//查询相对应的数据
-(TKDownLoadDataBaseModel *)downLoadSelectWithUrl:(NSString *)url;
//查找正在下载的任务
-(NSMutableArray *)downingItems;
//查询所有已下载完成的任务
-(NSMutableArray *)downedItems;
//查找要下载的任务是否已经在下载列表中
-(TKDownLoadDataBaseModel *)haveDownLoad:(NSString *)url;

@end
