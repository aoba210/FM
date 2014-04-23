//
//  CoreDataManager.h
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataManager : NSObject {
	NSString *_model;
	NSString *_file;
	NSString *_type;
	NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
}

- (id)initWithModel:(NSString *)model;
- (id)initWithModel:(NSString *)model file:(NSString *)file type:(NSString *)type;
+ (id)getInstance:(NSString *)model;
+ (id)getInstance:(NSString *)model file:(NSString *)file type:(NSString *)type;

- (NSArray *)select:(NSString *)entity where:(NSString *)where;
- (NSArray *)select:(NSString *)entity where:(NSString *)where limit:(NSNumber *)limit offset:(NSNumber *)offset;

- (NSManagedObject *)new:(NSString *)entity;
- (void)delete:(NSManagedObject *)object;
- (BOOL)deleteFrom:(NSString *)entity atIndexPath:(NSInteger)indexPath;
- (NSError *)save;

- (void)fetchedResultsController:(NSFetchedResultsController **)aFetchedResultsController entity:(NSString *)entity sort:(NSString *)sort;
- (NSManagedObjectContext *)managedObjectContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSString *)applicationDocumentsDirectory;

@property (nonatomic, retain) NSString *_model;
@property (nonatomic, retain) NSString *_file;
@property (nonatomic, retain) NSString *_type;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;

@end