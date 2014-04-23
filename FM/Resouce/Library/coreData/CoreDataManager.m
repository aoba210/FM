//
//  CoreDataManager.m
//  FM
//
//  Created by T.N on 2014/02/01.
//  Copyright (c) 2014年 Nishida.Takahiro. All rights reserved.
//

#import "CoreDataManager.h"


@implementation CoreDataManager
@synthesize _model;
@synthesize _file;
@synthesize _type;
@synthesize managedObjectContext;


/* init */

- (id)initWithModel:(NSString *)model {
	if (self = [super init]) {
		self._model = model;
		self._file = [NSString stringWithFormat:@"%@.sqlite", model];
		self._type = @"momd";
	}
	return self;
}

- (id)initWithModel:(NSString *)model file:(NSString *)file type:(NSString *)type {
	if (self = [super init]) {
		self._model = model;
		self._file = file;
		self._type = type;
	}
	return self;
}


/* singleton(実はプロパティのみしか返していない) */

static NSMutableDictionary *_instance = nil;

+ (id)getInstance:(NSString *)model {
	@synchronized(self) {
		if (_instance==nil) {
			_instance = [[NSMutableDictionary alloc] init];
		}
		if ([_instance objectForKey:model]==nil) {
			CoreDataManager *cdm = [[CoreDataManager alloc] initWithModel:model];
			[_instance setObject:cdm forKey:model];
		}
	}
	return [_instance objectForKey:model];
}

+ (id)getInstance:(NSString *)model file:(NSString *)file type:(NSString *)type {
	@synchronized(self) {
		if (_instance==nil) {
			_instance = [[NSMutableDictionary alloc] init];
		}
		if ([_instance objectForKey:model]==nil) {
			CoreDataManager *cdm = [[CoreDataManager alloc] initWithModel:model file:file type:type];
			[_instance setObject:cdm forKey:model];
		}
	}
	return [_instance objectForKey:model];
}

/* public */

- (NSArray *)select:(NSString *)entity where:(NSString *)where {
	return [self select:entity where:where limit:nil offset:nil];
}

- (NSArray *)select:(NSString *)entity where:(NSString *)where limit:(NSNumber *)limit offset:(NSNumber *)offset {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
	
	// where
	if (where!=nil && 0<[where length]) {
		[request setPredicate:[NSPredicate predicateWithFormat:where]];
	}
    
	// limit
	if (limit!=nil) {
		[request setFetchLimit:[limit intValue]];
	}
	if (offset!=nil) {
		[request setFetchOffset:[offset intValue]];
	}
	
	[request setEntity:entityDescription];
	
	NSError *error = nil;
	NSArray *fetchResult = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (error) {
		return nil;
	}
	return fetchResult;
}


- (NSManagedObject *)new:(NSString *)entity {
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self.managedObjectContext];
	return newManagedObject;
}

- (void)delete:(NSManagedObject *)object {
	[self.managedObjectContext deleteObject:object];
}

- (BOOL)deleteFrom:(NSString *)entity atIndexPath:(NSInteger)indexPath {
	NSArray *arr = [self select:entity where:nil limit:[NSNumber numberWithInt:1] offset:[NSNumber numberWithInt:indexPath]];
	if ([arr count]==1) {
		NSManagedObject *object = [arr objectAtIndex:0];
		[self.managedObjectContext deleteObject:object];
		return TRUE;
	}
	return FALSE;
}

- (NSError *)save {
    NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		return error;
	}
	return nil;
}


#pragma mark Fetched results controller

- (void)fetchedResultsController:(NSFetchedResultsController **)aFetchedResultsController entity:(NSString *)entity sort:(NSString *)sort {
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entitydesc];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sort ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    
    NSError *error = nil;
    if (![*aFetchedResultsController performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent:_file]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:_model ofType:_type];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}


/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end