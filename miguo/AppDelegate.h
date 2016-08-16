//
//  AppDelegate.h
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BaseTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) BaseTabBarController *rootViewController;
@property (assign, nonatomic) NSString *curNetworkStatus;   //当前网络状态

+ (instancetype)appDelegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

