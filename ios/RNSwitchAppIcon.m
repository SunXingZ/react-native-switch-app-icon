
#import "RNSwitchAppIcon.h"

@implementation RNSwitchAppIcon

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(switchAppIconWithName:(NSString *)iconName :(RCTResponseSenderBlock)callback) {
    
}

@end
  