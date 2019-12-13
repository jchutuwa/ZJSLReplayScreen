//
//  TopReplayManager.m
//  ZJSLReplayScreen
//
//  Created by 朱大安 on 2019/12/13.
//  Copyright © 2019 zhu.daan. All rights reserved.
//

#import "TopReplayManager.h"
#import <UIKit/UIKit.h>

@implementation TopReplayManager

#pragma mark 可用判断
+ (BOOL)systemVersionIsAvailable {
    NSString *version = [UIDevice currentDevice].systemVersion;
    //可用的判断是在9.0之后，只需要判断这个即可
    if ([version doubleValue] >= 9.0) {
        return YES;
    }
    return NO;
}

#pragma mark 风险判断
+ (BOOL)systemVersionIsRisk {
    NSString *version = [UIDevice currentDevice].systemVersion;
    //10.3以下系统均存在未知风险
    if ([version doubleValue] < 10.2) {
        return YES;
    }
    return NO;
}

#pragma mark 相册权限,在一开始就需要进行检测,如果在保存相册这一步才进行权限检测有几率出现保存失败
+ (BOOL)detectionPhotoState:(void(^)(void))authorizedResultBlock
{
    BOOL isAvalible = NO;
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined)
    {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized)
            {
                if (authorizedResultBlock)
                {
                    authorizedResultBlock();
                }
            }}];
    } else if (authStatus == PHAuthorizationStatusAuthorized)
    {
        isAvalible = YES;
        if (authorizedResultBlock)
        {
            authorizedResultBlock();
        }
    } else
    {
        NSLog(@"没有相册权限");
    }
    return isAvalible;
}

#pragma mark 视频压缩
+ (void)compressQuailtyWithInputURL:(NSURL*)inputURL
                     outputURL:(NSURL*)outputURL
                  blockHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset     presetName:AVAssetExportPresetMediumQuality];
    session.outputURL = outputURL;
    session.outputFileType = AVFileTypeMPEG4; //压缩格式
    [session exportAsynchronouslyWithCompletionHandler:^(void)
     {
         handler(session);
     }];
}

#pragma mark 转换时间
+ (BOOL)GetTimeChange:(NSDate *)time {
    NSDate *currentTimeDate = [NSDate date];    //  现在时间
    NSDate *getTimeDate = time;
    
    // 现在时间 与 获取时间 之差
    long dd = (long)[currentTimeDate timeIntervalSince1970] - [getTimeDate timeIntervalSince1970];
    
    BOOL timeOK = NO;
    
    // 1小时内。。
    if (dd/3600<1)
    {
        if (dd/60 <= 5) {
            timeOK = YES;
        }else{
            timeOK = NO;
        }
    }
    
    return timeOK;
}

@end
