//
//  MNCOCRIdentifierClient.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MNCOCRIdentifierClient.h"
#import "MOISplashScreenViewController.h"
#import "MOIIdentifierViewController.h"
#import "MOIUserDefault.h"
#import "MOIExtractKTPData.h"

@interface MNCOCRIdentifierClient ()

@property (nonatomic, retain) MOISplashScreenViewController *splashScreenController;
@property (nonatomic, retain) MOIIdentifierViewController *identifierController;

@end

@implementation MNCOCRIdentifierClient

- (instancetype)init {
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"MNCIdentifier.OCR"];
        self.splashScreenController = [[MOISplashScreenViewController alloc] initWithNibName:nil bundle:bundle];
        self.identifierController = [[MOIIdentifierViewController alloc] initWithNibName:nil bundle:bundle];
    }
    return self;
}

- (void)showOCRIdentifier:(UIViewController *)parent {
    [MOIUserDefault setFlashEnable:self.isFlashEnable];
    [MOIUserDefault setCameraOnly:self.isCameraOnly];
    
    if (self.isCameraOnly) {
        self.identifierController.modalPresentationStyle = UIModalPresentationFullScreen;
        self.identifierController.resultDelegate = self.delegate;
        [parent presentViewController:self.identifierController animated:YES completion:nil];
    } else {
        self.splashScreenController.modalPresentationStyle = UIModalPresentationFullScreen;
        self.splashScreenController.resultDelegate = self.delegate;
        [parent presentViewController:self.splashScreenController animated:YES completion:nil];
    }
}

@end
