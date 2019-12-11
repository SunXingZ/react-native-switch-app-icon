
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
    
    if ([name isEqualToString:@""]) {
        name = nil;
    }

    if (name) {
        NSString *currentName = [[UIApplication sharedApplication] alternateIconName];
        if ([currentName isEqualToString:name]) {
            callback(@[[NSString @""]]);
            return;
        }
    }
    
    [[UIApplication sharedApplication] setAlternateIconName:name completionHandler:^(NSError * _Nullable error) {
        if (error) {
            callback(@[@"name is change failed"]);
        } else {
            callback(@[[NSString @""]]);
        }
    }];
}

@end
  
