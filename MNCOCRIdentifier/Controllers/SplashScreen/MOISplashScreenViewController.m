//
//  MOISplashScreenViewController.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOISplashScreenViewController.h"
#import "MOIIdentifierViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MOISplashScreenViewController () {
    NSBundle *bundle;
}

@end

@implementation MOISplashScreenViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        bundle = [NSBundle bundleWithIdentifier:@"MNCIdentifier.MNCOCRIdentifier"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkPermissionVideo) userInfo:nil repeats:NO];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat heightContentImage = (height/100) * 70 ;
    
    UIImage *contentImage = [UIImage imageNamed:@"ic_logo" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *contentImageView = [UIImageView new];
    contentImageView.image = contentImage;
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:contentImageView];
    [contentImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [contentImageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [contentImageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [contentImageView.heightAnchor constraintEqualToConstant:heightContentImage].active = YES;
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = @"Optical Character Recognition";
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:32];
    contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:contentLabel];
    [contentLabel.topAnchor constraintEqualToAnchor:contentImageView.bottomAnchor constant:16].active = YES;
    [contentLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16].active = YES;
    [contentLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.text = @"Developed by : ";
    [footerLabel setFont:[UIFont systemFontOfSize:12]];
    
    UIImage *footerImage = [UIImage imageNamed:@"ic_innocent" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 24)];
    footerImageView.image = footerImage;
    
    UIStackView *footerStackView = [[UIStackView alloc] init];
    
    footerStackView.axis = UILayoutConstraintAxisHorizontal;
    footerStackView.alignment = UIStackViewAlignmentCenter;
    footerStackView.distribution = UIStackViewDistributionEqualSpacing;
    footerStackView.spacing = 0;
    
    [footerStackView addArrangedSubview:footerLabel];
    [footerStackView addArrangedSubview:footerImageView];
    
    footerStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:footerStackView];
    [footerStackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-24].active = YES;
    [footerStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

- (void)checkPermissionVideo {
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
        case AVAuthorizationStatusNotDetermined:
            [self requestCaptureDeviceVideoPermission];
            break;
        case AVAuthorizationStatusRestricted:
            [self errorResult];
            break;
        case AVAuthorizationStatusDenied:
            [self errorResult];
            break;
        case AVAuthorizationStatusAuthorized:
            [self gotoIdentifier];
            break;
    }
}

- (void)requestCaptureDeviceVideoPermission {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            [self gotoIdentifier];
        } else {
            [self errorResult];
        }
    }];
}

- (void)errorResult {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Camera permission not granted, please allow from your settings" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *closeButton = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            MNCOCRIdentifierResult *result = [MNCOCRIdentifierResult new];
            result.isSuccess = NO;
            result.errorMessage = @"Camera permission not granted";
            result.imagePath = nil;
            result.ktp = nil;
            
            [self.resultDelegate ocrResult:result];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:closeButton];
         
        [self presentViewController:alert animated:YES completion:nil];
        
    });
}

- (void)gotoIdentifier {
    dispatch_async(dispatch_get_main_queue(), ^{
        MOIIdentifierViewController *identifierController = [[MOIIdentifierViewController alloc] initWithNibName:nil bundle:self->bundle];
        identifierController.modalPresentationStyle = UIModalPresentationFullScreen;
        identifierController.resultDelegate = self.resultDelegate;
        UIViewController *currentViewController = [self presentingViewController];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [currentViewController presentViewController:identifierController animated:YES completion:nil];
        }];
    });
}

@end
