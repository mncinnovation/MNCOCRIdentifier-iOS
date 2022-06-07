//
//  MOIUserDefault.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 07/06/22.
//

#import "MOIUserDefault.h"

@implementation MOIUserDefault

+ (void)setFlashEnable:(BOOL)isEnable {
    [[NSUserDefaults standardUserDefaults] setBool:isEnable forKey:@"FLASH_ENABLE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)isFlashEnable {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"FLASH_ENABLE"];
}

@end
