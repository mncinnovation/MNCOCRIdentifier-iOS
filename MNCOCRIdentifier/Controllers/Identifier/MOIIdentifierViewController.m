//
//  MOIIdentifierViewController.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIIdentifierViewController.h"
#import "MOIDismissDelegate.h"
#import "MOIUtils.h"
#import "MOIComparationModel.h"
#import "MOICorrectionViewController.h"
#import "MOIExtractKTPData.h"
#import "MOIICameraView.h"
#import "MOIIKTPFrameView.h"
#import "MOIIBottomView.h"
#import "MOIUserDefault.h"
#import "MNCOCRIdentifierResult.h"

@import MLImage;
@import MLKitObjectDetectionCommon;
@import MLKitObjectDetection;
@import MLKitVision;

static const CGFloat percentageToPass = 80;

@interface MOIIdentifierViewController () <MOIDismissDelegate, MOIICameraDelegate> {
    NSBundle *bundle;
    NSTimer *timer;
    NSMutableArray *capturedImages;
    UIImage *lastImage;
    CGRect lastRect;
    MOIKTPDataModel *ktpData;
    BOOL isCardInFrame;
    BOOL hasCompleteScanning;
    int countdown;
}

@property (strong, nonatomic) MOIICameraView *cameraView;
@property (strong, nonatomic) MOIIKTPFrameView *ktpFrameView;
@property (strong, nonatomic) MOIIBottomView *bottomView;
@property (strong, nonatomic) UIView *coordinateView;
@property (strong, nonatomic) UIView *captureFlashView;

@end

@implementation MOIIdentifierViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        bundle = [NSBundle bundleWithIdentifier:@"MNCIdentifier.MNCOCRIdentifier"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    hasCompleteScanning = NO;
    capturedImages = [NSMutableArray new];
    
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.cameraView startCamera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.cameraView stopCamera];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor blackColor];
    
    self.cameraView = [MOIICameraView new];
    self.cameraView.delegate = self;
    self.cameraView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cameraView];
    [self.cameraView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.cameraView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-124].active = YES;
    [self.cameraView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.cameraView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    self.ktpFrameView = [MOIIKTPFrameView new];
    self.ktpFrameView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.ktpFrameView];
    [self.ktpFrameView.topAnchor constraintEqualToAnchor:self.cameraView.topAnchor].active = YES;
    [self.ktpFrameView.bottomAnchor constraintEqualToAnchor:self.cameraView.bottomAnchor].active = YES;
    [self.ktpFrameView.leftAnchor constraintEqualToAnchor:self.cameraView.leftAnchor].active = YES;
    [self.ktpFrameView.rightAnchor constraintEqualToAnchor:self.cameraView.rightAnchor].active = YES;
    
    self.coordinateView = [UIView new];
    self.coordinateView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.coordinateView];
    [self.coordinateView.topAnchor constraintEqualToAnchor:self.cameraView.topAnchor].active = YES;
    [self.coordinateView.bottomAnchor constraintEqualToAnchor:self.cameraView.bottomAnchor].active = YES;
    [self.coordinateView.leftAnchor constraintEqualToAnchor:self.cameraView.leftAnchor].active = YES;
    [self.coordinateView.rightAnchor constraintEqualToAnchor:self.cameraView.rightAnchor].active = YES;
    
    self.captureFlashView = [UIView new];
    self.captureFlashView.layer.cornerRadius = 20;
    self.captureFlashView.layer.masksToBounds = YES;
    self.captureFlashView.alpha = 0.0;
    self.captureFlashView.backgroundColor = [UIColor whiteColor];
    self.captureFlashView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.captureFlashView];
    [self.captureFlashView.topAnchor constraintEqualToAnchor:self.cameraView.topAnchor].active = YES;
    [self.captureFlashView.bottomAnchor constraintEqualToAnchor:self.cameraView.bottomAnchor].active = YES;
    [self.captureFlashView.leftAnchor constraintEqualToAnchor:self.cameraView.leftAnchor].active = YES;
    [self.captureFlashView.rightAnchor constraintEqualToAnchor:self.cameraView.rightAnchor].active = YES;
    
    
    UIView *flashView = [UIView new];
    flashView.backgroundColor = [UIColor whiteColor];
    flashView.hidden = ![MOIUserDefault isFlashEnable];
    flashView.layer.cornerRadius = 24;
    flashView.layer.masksToBounds = YES;
    flashView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:flashView];
    [flashView.bottomAnchor constraintEqualToAnchor:self.cameraView.bottomAnchor constant:-24].active = YES;
    [flashView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [flashView.widthAnchor constraintEqualToConstant:48].active = YES;
    [flashView.heightAnchor constraintEqualToConstant:48].active = YES;
    
    UIImage *flashImage = [UIImage imageNamed:@"ic_flash" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *flashImageView = [UIImageView new];
    flashImageView.image = flashImage;
    flashImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [flashView addSubview:flashImageView];
    [flashImageView.centerXAnchor constraintEqualToAnchor:flashView.centerXAnchor].active = YES;
    [flashImageView.centerYAnchor constraintEqualToAnchor:flashView.centerYAnchor].active = YES;
    [flashImageView.heightAnchor constraintEqualToConstant:21].active = YES;
    [flashImageView.widthAnchor constraintEqualToConstant:21].active = YES;
    
    UIButton *flashButton = [UIButton new];
    flashButton.translatesAutoresizingMaskIntoConstraints = NO;
    [flashButton addTarget:self action:@selector(flashTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:flashButton];
    [flashButton.topAnchor constraintEqualToAnchor:flashView.topAnchor].active = YES;
    [flashButton.bottomAnchor constraintEqualToAnchor:flashView.bottomAnchor].active = YES;
    [flashButton.leftAnchor constraintEqualToAnchor:flashView.leftAnchor].active = YES;
    [flashButton.rightAnchor constraintEqualToAnchor:flashView.rightAnchor].active = YES;
    
    UIStackView *backStackView = [[UIStackView alloc] init];
    backStackView.axis = UILayoutConstraintAxisHorizontal;
    backStackView.distribution = UIStackViewDistributionFill;
    backStackView.alignment = UIStackViewAlignmentCenter;
    backStackView.spacing = 16;
    backStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *backImage = [UIImage imageNamed:@"ic_arrow_back" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    backImageView.image = backImage;
    
    UIButton *backLabel = [[UIButton alloc] init];
    backLabel.titleLabel.font = [UIFont systemFontOfSize:16];
    [backLabel setTitle:@"Kembali" forState:UIControlStateNormal];
    [backLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backLabel addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [backStackView addArrangedSubview:backImageView];
    [backStackView addArrangedSubview:backLabel];
    [backStackView addArrangedSubview:[UIView new]];
    
    [self.view addSubview:backStackView];
    [backStackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:28].active = YES;
    [backStackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:33].active = YES;
    
    self.bottomView = [MOIIBottomView new];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bottomView];
    [self.bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.bottomView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.bottomView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.bottomView.heightAnchor constraintEqualToConstant:196].active = YES;
    [self.bottomView setHidden: YES];
}

- (void)detectIdentification:(MLKVisionImage *)image width:(CGFloat)width height:(CGFloat)height {
    if (!image) {
        return;
    }
    
    MLKObjectDetectorOptions *options = [MLKObjectDetectorOptions new];
    options.shouldEnableClassification = NO;
    options.shouldEnableMultipleObjects = NO;
    options.detectorMode = MLKObjectDetectorModeSingleImage;
    
    
    MLKObjectDetector *objectDetector = [MLKObjectDetector objectDetectorWithOptions:options];
    
    [objectDetector processImage:image completion:^(NSArray<MLKObject *> *_Nullable objects, NSError *_Nullable error) {
        for (UIView *annotationView in self.coordinateView.subviews) {
            [annotationView removeFromSuperview];
        }
        
        if (error != nil) {
            NSString *errorString =
            error ? error.localizedDescription : @"No ObjectDetected";
            NSLog(@"%@", errorString);
        }
        
        if (!objects || objects.count == 0) {
            NSLog(@"On-Device object detector returned no results.");
            return;
        }
        
        for (MLKObject *object in objects) {
            CGRect normalizedRect = CGRectMake(object.frame.origin.x / width, object.frame.origin.y / height, object.frame.size.width / width, object.frame.size.height / height);
            CGRect standardizedRect = CGRectStandardize([self.cameraView.videoPreviewLayer rectForMetadataOutputRectOfInterest:normalizedRect]);
            self->lastRect = object.frame;
            MOIComparationModel *comparationModel = [MOIUtils getRectAccuration:standardizedRect byComparison:self.ktpFrameView.ktpView.frame enableDot:NO viewForDot:self.coordinateView];
            
            [self checkCardInFrame:comparationModel];
            if (self->isCardInFrame) {
                if (self->timer == nil && !self->hasCompleteScanning) {
                    [self startTimer];
                    [self hideBottomView:NO];
                    NSLog(@"show");
                }
            } else {
                [self->capturedImages removeAllObjects];
                [self stopTimer];
                NSLog(@"hide");
                [self hideBottomView:YES];
            }
        }
    }];
}

- (void)checkCardInFrame:(MOIComparationModel *)comparationModel {
    CGFloat percentageMatchToFrame = comparationModel.accuratePercentage;
    
    isCardInFrame = percentageMatchToFrame > percentageToPass;
}

- (void)startTimer {
    countdown = 6;
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    }
}

- (void)stopTimer {
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)timerHandler {
    NSString *countString = [NSString stringWithFormat:@"%d", (countdown/2)];
    self.bottomView.counterLabel.text = countString;
    [capturedImages addObject:lastImage];
    countdown -= 1;
    if (countdown < 0) {
        hasCompleteScanning = YES;
        [self stopTimer];
        [self.cameraView stopCamera];
        [self hideBottomView:YES];
        [self captureScreen];
    }
}

- (void)hideBottomView:(BOOL)isHide {
    if (self.bottomView.isHidden != isHide) {
        if (!isHide) {
            [UIView transitionWithView:self.bottomView duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self.bottomView setHidden: NO];
            } completion:NULL];
        } else {
            [UIView transitionWithView:self.bottomView duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [self.bottomView setHidden: YES];
            } completion:NULL];
        }
    }
}

- (void)captureScreen {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.captureFlashView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.captureFlashView.alpha = 0.0;
        self->lastImage = [self cropImage:self->lastImage];
        self->ktpData = [MOIKTPDataModel new];
        [self extractedData];
    }];
}

- (void)extractedData {
    if (capturedImages.count > 0) {
        UIImage *croppedImage = [self cropImage:capturedImages.lastObject];
        MOIExtractKTPData *extractKTPData = [MOIExtractKTPData new];
        [extractKTPData extractImageFromCamera:croppedImage isImageRotate:YES completion:^(MOIKTPDataModel * _Nullable data, CGFloat completedPercentage) {
            CGFloat percentage = [self->ktpData insertData:data];
            [self->capturedImages removeLastObject];
            if (percentage == 100 || self->capturedImages.count == 0) {
                self->hasCompleteScanning = NO;
                if (percentage < 50) {
                    [self showErrorMessage];
                } else {
                    [self finishExtracting];
                }
            } else if (self->capturedImages.count > 0) {
                [self extractedData];
            }
        }];
    }
}

- (void)showErrorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"KTP not detected" message:@"KTP not detected or collection of KTP data is not more than 50%, Please capture again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *closeButton = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.cameraView startCamera];
    }];
    
    [alert addAction:closeButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)finishExtracting {
    UIImage *rotatedImage = [UIImage imageWithCGImage:self->lastImage.CGImage scale:1.0 orientation:UIImageOrientationRight];
    if ([MOIUserDefault isCameraOnly]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ktp.png"];
        
        [UIImageJPEGRepresentation(rotatedImage, 1) writeToFile:filePath atomically:YES];
        
        [ktpData replaceDataNil];
        
        MNCOCRIdentifierResult *result = [MNCOCRIdentifierResult new];
        result.isSuccess = YES;
        result.errorMessage = @"Success";
        result.imagePath = filePath;
        result.ktp = ktpData;
        
        [self.resultDelegate ocrResult:result];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        MOICorrectionViewController *correctionController = [[MOICorrectionViewController alloc] initWithNibName:nil bundle:self->bundle];
        correctionController.modalPresentationStyle = UIModalPresentationFullScreen;
        correctionController.ktpData = ktpData;
        correctionController.ktpImage = rotatedImage;
        correctionController.dismissDelegate = self;
        correctionController.resultDelegate = self.resultDelegate;
        [self presentViewController:correctionController animated:YES completion:nil];
    }
}


- (UIImage *)cropImage:(UIImage *)image {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], lastRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

- (void)flashTapped {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!device.torchActive) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                //torchIsOn = YES; //define as a variable/property if you need to know status
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                //torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}

- (void)dismiss {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)screenshotOfVideoStream:(CMSampleBufferRef)samImageBuff {
    CVImageBufferRef imageBuffer =
    CMSampleBufferGetImageBuffer(samImageBuff);
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:imageBuffer];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext
                             createCGImage:ciImage
                             fromRect:CGRectMake(0, 0,
                                                 CVPixelBufferGetWidth(imageBuffer),
                                                 CVPixelBufferGetHeight(imageBuffer))];
    
    UIImage *image = [[UIImage alloc] initWithCGImage:videoImage];
    CGImageRelease(videoImage);
    return image;
}

- (void)streamOutput:(nonnull CMSampleBufferRef)streamBuffer {
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(streamBuffer);
    MLKVisionImage *visionImage = [[MLKVisionImage alloc] initWithBuffer:streamBuffer];
    UIImageOrientation orientation = [MOIUtils imageOrientationFromDevicePosition: AVCaptureDevicePositionBack];
    
    visionImage.orientation = orientation;
    
    CGFloat imageWidth = CVPixelBufferGetWidth(imageBuffer);
    CGFloat imageHeight = CVPixelBufferGetHeight(imageBuffer);
    
    UIImage *convertImage = [self screenshotOfVideoStream:streamBuffer];
    lastImage = [UIImage imageWithCGImage:[convertImage CGImage] scale:[convertImage scale] orientation:orientation];
    
    [self detectIdentification:visionImage width:imageWidth height:imageHeight];
}

- (void)backTapped {
    MNCOCRIdentifierResult *result = [MNCOCRIdentifierResult new];
    result.isSuccess = NO;
    result.errorMessage = @"Canceled by user";
    result.imagePath = nil;
    result.ktp = nil;
    
    [self.resultDelegate ocrResult:result];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
