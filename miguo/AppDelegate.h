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

#pragma mark - 本地通知
/*
 本地通知是由本地应用触发的，它是基于时间行为的一种通知形式，例如闹钟定时、待办事项提醒，又或者一个应用在一段时候后不使用通常会提示用户使用此应用等都是本地通知。创建一个本地通知通常分为以下几个步骤：
 
 1 创建UILocalNotification。
 2 设置处理通知的时间fireDate。
 3 配置通知的内容：通知主体、通知声音、图标数字等。
 4 配置通知传递的自定义数据参数userInfo（这一步可选）。
 5 调用通知，可以使用scheduleLocalNotification:按计划调度一个通知，也可以使用presentLocalNotificationNow立即调用通知。
 */

#pragma mark - 推送通知
/*
 和本地通知不同，推送通知是由应用服务提供商发起的，通过苹果的APNs（Apple Push Notification Server）发送到应用客户端。
 苹果官方关于推送通知的过程示意图：PushNotification_FlowChart
 
 推送通知的过程可以分为以下几步：
 
 1 应用服务提供商从服务器端把要发送的消息和设备令牌（device token）发送给苹果的消息推送服务器APNs。
 2 APNs根据设备令牌在已注册的设备（iPhone、iPad、iTouch、mac等）查找对应的设备，将消息发送给相应的设备。
 3 客户端设备接将接收到的消息传递给相应的应用程序，应用程序根据用户设置弹出通知消息。
 
 */

#pragma mark - PushNotification_FlowChartDetail
/*
 1.应用程序注册APNs推送消息。
 
 说明：
 
 a.只有注册过的应用才有可能接收到消息，程序中通常通过UIApplication的registerUserNotificationSettings:方法注册，iOS8中通知注册的方法发生了改变，如果是iOS7及之前版本的iOS请参考其他代码。
 
 b.注册之前有两个前提条件必须准备好：开发配置文件（provisioning profile，也就是.mobileprovision后缀的文件）的App ID不能使用通配ID必须使用指定APP ID并且生成配置文件中选择Push Notifications服务，一般的开发配置文件无法完成注册；应用程序的Bundle Identifier必须和生成配置文件使用的APP ID完全一致。
 
 2.iOS从APNs接收device token，在应用程序获取device token。
 
 说明：
 
 a.在UIApplication的-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken代理方法中获取令牌，此方法发生在注册之后。
 
 b.如果无法正确获得device token可以在UIApplication的-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error代理方法中查看详细错误信息，此方法发生在获取device token失败之后。
 
 c.必须真机调试，模拟器无法获取device token。
 
 3.iOS应用将device token发送给应用程序提供商，告诉服务器端当前设备允许接收消息。
 
 说明：
 
 a.device token的生成算法只有Apple掌握，为了确保算法发生变化后仍然能够正常接收服务器端发送的通知，每次应用程序启动都重新获得device token（注意：device token的获取不会造成性能问题，苹果官方已经做过优化）。
 
 b.通常可以创建一个网络连接发送给应用程序提供商的服务器端， 在这个过程中最好将上一次获得的device token存储起来，避免重复发送，一旦发现device token发生了变化最好将原有的device token一块发送给服务器端，服务器端删除原有令牌存储新令牌避免服务器端发送无效消息。
 
 4.应用程序提供商在服务器端根据前面发送过来的device token组织信息发送给APNs。
 
 说明：
 
 a.发送时指定device token和消息内容，并且完全按照苹果官方的消息格式组织消息内容，通常情况下可以借助其他第三方消息推送框架来完成。一个开源的类库Push Sharp来给APNs发送消息 ,除了可以给Apple设备推送消息，Push Sharp还支持Android、Windows Phone等多种设备.
 
    要开发消息推送应用不能使用一般的开发配置文件，这里还需要注意：
    如果服务器端要给APNs发送消息其秘钥也必须是通过APNs Development iOS类型的证书来导出的，一般的iOS
    Development 类型的证书导出的秘钥无法用作服务器端发送秘钥。
 
 5.APNs根据消息中的device token查找已注册的设备推送消息。
 
 说明：
 
 a.正常情况下可以根据device token将消息成功推送到客户端设备中，但是也不排除用户卸载程序的情况，此时推送消息失败，APNs会将这个错误消息通知服务器端以避免资源浪费（服务器端此时可以根据错误删除已经存储的device token，下次不再发送）。
 */

#pragma mark - 补充--iOS开发证书、秘钥
/*
 证书
 
 iOS常用的证书包括开发证书和发布证书，无论是真机调试还是最终发布应用到App Store这两个证书都是必须的，它是iOS开发的基本证书。
 
 a.开发证书：开发证书又分为普通开发证书和推送证书，如果仅仅是一般的应用则前者即可满足，但是如果开发推送应用则必须使用推送证书。
 
 b.发布证书：发布证书又可以分为普通发布证书、推送证书、Pass Type ID证书、站点发布证书、VoIP服务证书、苹果支付证书。同样的，对于需要使用特殊服务的应用则必须选择对应的证书。
 应用标识
 
 App ID,应用程序的唯一标识，对应iOS应用的Bundle Identifier，App ID在苹果开发者中心中分为通配应用ID和明确的应用ID,前者一般用于普通应用开发，一个ID可以适用于多个不同标识的应用；但是对于使用消息推送、Passbook、站点发布、iCloud等服务的应用必须配置明确的应用ID。
 设备标识
 
 UDID,用于标识每一台硬件设备的标示符。注意它不是device token，device token是根据UDID使用一个只有Apple自己才知道的算法生成的一组标示符。
 配置简介
 
 Provisioning Profiles,平时又称为PP文件。将UDID、App ID、开发证书打包在一起的配置文件，同样分为开发和发布两类配置文件。
 秘钥
 
 在申请开发证书时必须要首先提交一个秘钥请求文件，对于生成秘钥请求文件的mac，如果要做开发则只需要下载证书和配置简介即可开发。但是如果要想在其他机器上做开发则必须将证书中的秘钥导出（导出之后是一个.p12文件），然后导入其他机器。同时对于类似于推送服务器端应用如果要给APNs发送消息，同样需要使用.p12秘钥文件，并且这个秘钥文件需要是推送证书导出的对应秘钥。
 */

#pragma mark - 补充--通知中心
/*
 对于很多初学者往往会把iOS中的本地通知、推送通知和iOS通知中心的概念弄混。其实二者之间并没有任何关系，事实上它们都不属于一个框架，前者属于UIKit框架，后者属于Foundation框架。
 
 通知中心实际上是iOS程序内部之间的一种消息广播机制，主要为了解决应用程序内部不同对象之间解耦而设计。它是基于观察者模式设计的，不能跨应用程序进程通信，当通知中心接收到消息之后会根据内部的消息转发表，将消息发送给订阅者。
 
 NSNotification：代表通知内容的载体，主要有三个属性：name代表通知名称，object代表通知的发送者，userInfo代表通知的附加信息。
 
 */
