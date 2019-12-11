
#import "RNSwitchAppIcon.h"

@implementation RNSwitchAppIcon

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(switchAppIconWithName:(NSString *)name :(RCTResponseSenderBlock)callback) {
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        callback(@[@"supportsAlternateIcons unsupported"]);
        return;
    }
    
    if ([iconName isEqualToString:@""]) {
        name = nil;
    }
    
    [[UIApplication sharedApplication] setAlternateIconName:name completionHandler:^(NSError * _Nullable error) {
        if (error) {
            callback(@[@"name is change failed"]);
        } else {
            callback(@[[NSNull null]]);
        }
    }];
}

@end
  
