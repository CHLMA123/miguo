//
//  AppDelegate.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)appDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _rootViewController = [[BaseTabBarController alloc] init];
    _window.rootViewController = _rootViewController;
    [_window makeKeyAndVisible];
    
    // 首先注册通知请求用户允许通知；
#if 1
    
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types != UIUserNotificationTypeNone) {
        
        [self addLocalNotification];
        
    }else{
    
        if (IOS_VERSION >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }else {
            
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert |
             UIRemoteNotificationTypeBadge |
             UIRemoteNotificationTypeSound
             ];
        }
    }
    
#endif

//    //添加通知
//    [self addLocalNotification];
//    
//    //接收通知参数
//    UILocalNotification *notification=[launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    NSDictionary *userInfo= notification.userInfo;
//    
//    [userInfo writeToFile:@"/Users/machunlei/Desktop/didFinishLaunchingWithOptions.txt" atomically:YES];
//    NSLog(@"didFinishLaunchingWithOptions:The userInfo is %@.",userInfo);
    
    self.curNetworkStatus = @"WiFi";//默认状态为wifi
    [self registerReachability];
    
    return YES;
}

#pragma mark 1 - LocalNotification私有方法
#pragma mark 添加本地通知
/*
    1 在使用通知之前必须注册通知类型，如果用户不允许应用程序发送通知，则以后就无法发送通知，除非用户手动到iOS设置中打开通知。
    2 本地通知是有操作系统统一调度的，只有在应用退出到后台或者关闭才能收到通知。(注意：这一点对于后面的推送通知也是完全适用的。 ）
    3 通知的声音是由iOS系统播放的，格式必须是Linear PCM、MA4（IMA/ADPCM）、µLaw、aLaw中的一种，并且播放时间必须在30s内，否则将被系统声音替换，同时自定义声音文件必须放到main boundle中。
    4 本地通知的数量是有限制的，最近的本地通知最多只能有64个，超过这个数量将被系统忽略。
    5 如果想要移除本地通知可以调用UIApplication的cancelLocalNotification:或cancelAllLocalNotifications移除指定通知或所有通知。
 */
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

#pragma mark 接收本地通知时触发
/*
    在iOS中如果点击一个弹出通知（或者锁屏界面滑动查看通知），默认会自动打开当前应用。
    由于通知由系统调度那么此时进入应用有两种情况：如果应用程序已经完全退出那么此时会调用
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions方法；
    如果此时应用程序还在运行（无论是在前台还是在后台）则会调用
    -(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification方法接收消息参数。
    当然如果是后者自然不必多说，因为参数中已经可以拿到notification对象，只要读取userInfo属性即可。
    如果是前者的话则可以访问launchOptions中键为UIApplicationLaunchOptionsLocalNotificationKey
    的对象，这个对象就是发送的通知，由此对象再去访问userInfo。
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    NSDictionary *userInfo=notification.userInfo;
    [userInfo writeToFile:@"/Users/machunlei/Desktop/didReceiveLocalNotification.txt" atomically:YES];
    NSLog(@"didReceiveLocalNotification:The userInfo is %@",userInfo);
    
}

#pragma mark 调用过用户注册通知方法之后执行
/*
 （也就是调用完registerUserNotificationSettings:方法之后执行） 一旦调用完注册方法，无论用户是否选择允许通知此刻都会调用,在这个方法中根据用户的选择：如果是允许通知则会按照前面的步骤创建通知并在一定时间后执行。
 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark 2 - RemoteNotification私有方法
/*
    注册推送通知，获取device token存储到偏好设置中，并且如果新获取的device token不同于
    偏好设置中存储的数据则发送给服务器端，更新服务器端device token列表。
 */

/**
 *  添加设备令牌到服务器端
 *
 *  @param deviceToken 设备令牌
 */
-(void)addDeviceToken:(NSData *)deviceToken{
    NSString *key=@"DeviceToken";
    NSData *oldToken= [[NSUserDefaults standardUserDefaults]objectForKey:key];
    //如果偏好设置中的已存储设备令牌和新获取的令牌不同则存储新令牌并且发送给服务器端
    if (![oldToken isEqualToData:deviceToken]) {
        [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:key];
        [self sendDeviceTokenWidthOldDeviceToken:oldToken newDeviceToken:deviceToken];
    }
}

-(void)sendDeviceTokenWidthOldDeviceToken:(NSData *)oldToken newDeviceToken:(NSData *)newToken{
    //注意一定确保真机可以正常访问下面的地址
    NSString *urlStr=@"http://192.168.1.101/RegisterDeviceToken.aspx";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10.0];
    [requestM setHTTPMethod:@"POST"];
    NSString *bodyStr=[NSString stringWithFormat:@"oldToken=%@&newToken=%@",oldToken,newToken];
    NSData *body=[bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    [requestM setHTTPBody:body];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask= [session dataTaskWithRequest:requestM completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Send failure,error is :%@",error.localizedDescription);
        }else{
            NSLog(@"Send Success!");
        }
        
    }];
    [dataTask resume];
}

#pragma mark 注册推送通知之后
//在此接收设备令牌
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [self addDeviceToken:deviceToken];
    NSLog(@"device token:%@",deviceToken);
}

#pragma mark 获取device token失败后
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error.localizedDescription);
    [self addDeviceToken:nil];
}

#pragma mark 接收到推送通知之后
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"receiveRemoteNotification,userInfo is %@",userInfo);
}

#pragma mark 3 - 应用程序生命周期
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

/*
 #pragma mark 进入前台后设置消息信息
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark 4 - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.test.miguo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"miguo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"miguo.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark 5 - registerReachability
- (void)registerReachability{
    //监测网络
    [[NetworkManager shareInstance] checkingNetwork:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case 2:
                NSLog(@"ReachableViaWiFi");
                self.curNetworkStatus = @"WiFi";
                break;
            case 1:
                NSLog(@"ReachableViaWWAN");
                self.curNetworkStatus = @"WWAN";
                break;
            case 0:
                NSLog(@"NotReachable");
                self.curNetworkStatus = @"NotReachable";
                break;
            default:
                NSLog(@"Unknown");
                break;
        }
        
    }];
    
}

@end
