//
//  ViewController.m
//  qwe
//
//  Created by FreshWater on 17/7/5.
//  Copyright © 2017年 FreshWater. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)BOOL isAll;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;// 所有人员数组
@property (nonatomic, strong)NSMutableArray *selectArray;//选取人员的数组
@property(nonatomic,strong) NSMutableArray *userIdArray;// 所有的userId

@end
#define KAlarmLocalNotificationKey @"KAlarmLocalNotificationKey"


#define screenW self.view.frame.size.width
#define kNavHight self.navigationController.navigationBar.frame.size.height

#define screenH self.view.frame.size.height
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isAll = NO;
    
    [ViewController registerLocalNotification:10];// 4秒后


     NSTimer *spectiaclTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(special:) userInfo:nil repeats:YES];

    
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.tableView];

    self.selectArray = [@[] mutableCopy];
    self.dataSourceArray = [@[] mutableCopy];
    NSArray *arr =@[@"1",@"2",@"3"];
    self.dataSourceArray = [arr mutableCopy];
    
    NSArray *arr2 =@[@"1",@"2"];
    self.selectArray = [arr2 mutableCopy];

    
    [self.dataSourceArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        //      NSLog(@"%@",obj );
        
        
        for (int i = 0; i <self.selectArray.count; i++) {
            
            
            
            if (obj == self.selectArray[i]) {
                
                NSLog(@"%@-索引%d",obj, (int)idx);
                
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;//出现右面勾选的对勾

            }
            
        }
        
    }];

    
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH-kNavHight-22) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    //    _tableView.editing = YES;
     //  _tableView.allowsMultipleSelectionDuringEditing = YES;
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_Id = @"row";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_Id];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
   // cell.selectedBackgroundView = [[UIView alloc] init];
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isAll) {
        
        
        [self.selectArray addObject:self.dataSourceArray[indexPath.row]];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.selectArray removeObject:self.dataSourceArray[indexPath.row]];
    NSLog(@"%@",self.selectArray);
}

-(void)special:(id)sen{
    
    NSLog(@"1");
    
}

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"晚安";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"前台的" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
