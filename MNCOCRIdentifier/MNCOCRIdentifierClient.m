//
//  MNCOCRIdentifierClient.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MNCOCRIdentifierClient.h"
#import "MOISplashScreenViewController.h"

@interface MNCOCRIdentifierClient ()

@property (nonatomic, retain) MOISplashScreenViewController *splashScreenController;

@end

@implementation MNCOCRIdentifierClient

- (instancetype)init {
    self = [super init];
    if (self) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"MNCIdentifier.OCR"];
        self.splashScreenController = [[MOISplashScreenViewController alloc] initWithNibName:nil bundle:bundle];
    }
    return self;
}

- (void)setDelegate:(id<MNCOCRIdentifierDelegate>)delegate {
    self.splashScreenController.resultDelegate = delegate;
}

- (id<MNCOCRIdentifierDelegate>)delegate {
    return self.splashScreenController.resultDelegate;
}

- (void)showOCRIdentifier:(UIViewController *)parent {
    self.splashScreenController.modalPresentationStyle = UIModalPresentationFullScreen;
    [parent presentViewController:self.splashScreenController animated:YES completion:nil];
}

@end
