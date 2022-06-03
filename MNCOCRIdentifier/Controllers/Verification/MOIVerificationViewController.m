//
//  MOIVerificationViewController.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIVerificationViewController.h"
#import "MOIUtils.h"

@interface MOIVerificationViewController () {
    NSBundle *bundle;
}

@property (strong, nonatomic) UIImageView *ktpImageView;
@property (strong, nonatomic) UILabel *provinsiLabel;
@property (strong, nonatomic) UILabel *kabKotaLabel;
@property (strong, nonatomic) UILabel *nikLabel;
@property (strong, nonatomic) UILabel *namaLabel;
@property (strong, nonatomic) UILabel *tempatLahirLabel;
@property (strong, nonatomic) UILabel *tanggalLahirLabel;
@property (strong, nonatomic) UILabel *jenisKelaminLabel;
@property (strong, nonatomic) UILabel *goldarLabel;
@property (strong, nonatomic) UILabel *alamatLabel;
@property (strong, nonatomic) UILabel *rtLabel;
@property (strong, nonatomic) UILabel *rwLabel;
@property (strong, nonatomic) UILabel *kelurahanLabel;
@property (strong, nonatomic) UILabel *kecamatanLabel;
@property (strong, nonatomic) UILabel *agamaLabel;
@property (strong, nonatomic) UILabel *statusPerkawinanLabel;
@property (strong, nonatomic) UILabel *pekerjaanLabel;
@property (strong, nonatomic) UILabel *kewarganegaraanLabel;
@property (strong, nonatomic) UILabel *berlakuHinggaLabel;

@end

@implementation MOIVerificationViewController

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
    [self setupData];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    UIStackView *contentStackView = [UIStackView new];
    contentStackView.spacing = 16;
    contentStackView.alignment = UIStackViewAlignmentFill;
    contentStackView.axis = UILayoutConstraintAxisVertical;
    contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    contentStackView.layoutMarginsRelativeArrangement = YES;
    contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(14, 20, 58, 20);
    [scrollView addSubview:contentStackView];
    [contentStackView.topAnchor constraintEqualToAnchor:scrollView.topAnchor].active = YES;
    [contentStackView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor].active = YES;
    [contentStackView.leftAnchor constraintEqualToAnchor:scrollView.leftAnchor].active = YES;
    [contentStackView.rightAnchor constraintEqualToAnchor:scrollView.rightAnchor].active = YES;
    [contentStackView.widthAnchor constraintEqualToAnchor:scrollView.widthAnchor].active = YES;
    
    UIStackView *backStackView = [UIStackView new];
    backStackView.axis = UILayoutConstraintAxisHorizontal;
    backStackView.distribution = UIStackViewDistributionFill;
    backStackView.alignment = UIStackViewAlignmentCenter;
    backStackView.spacing = 16;
    backStackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImage *backImage = [UIImage imageNamed:@"ic_arrow_back" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    backImageView.image = backImage;
    
    UIButton *backLabel = [UIButton new];
    [backLabel setTitle:@"Kembali" forState:UIControlStateNormal];
    [backLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backLabel.titleLabel.font = [UIFont systemFontOfSize:16];
    [backLabel addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [backStackView addArrangedSubview:backImageView];
    [backStackView addArrangedSubview:backLabel];
    [backStackView addArrangedSubview:[UIView new]];
    
    [contentStackView addArrangedSubview:backStackView];
    
    UIView *firstSeparator = [UIView new];
    firstSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [contentStackView addArrangedSubview:firstSeparator];
    [firstSeparator.heightAnchor constraintEqualToConstant:16].active = YES;
    
    UILabel *imageLabel = [UILabel new];
    imageLabel.text = @"Image";
    imageLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    imageLabel.textColor = [UIColor whiteColor];
    
    [contentStackView addArrangedSubview:imageLabel];
  
    UIStackView *ktpImageStackView = [UIStackView new];
    ktpImageStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(10, 16, 10, 16);
    ktpImageStackView.backgroundColor = [UIColor whiteColor];
    ktpImageStackView.layer.cornerRadius = 10;
    ktpImageStackView.layer.masksToBounds = YES;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat widthKtpView = width - 60;
    CGFloat heightKtpView = (539 * widthKtpView) / 856;
    
    self.ktpImageView = [UIImageView new];
    self.ktpImageView.image = self.ktpImage;
    self.ktpImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [ktpImageStackView addArrangedSubview:self.ktpImageView];
    
    [contentStackView addArrangedSubview:ktpImageStackView];
    [ktpImageStackView.heightAnchor constraintEqualToConstant:heightKtpView].active = YES;
    [ktpImageStackView.widthAnchor constraintEqualToConstant:widthKtpView].active = YES;
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = @"Text";
    textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    textLabel.textColor = [UIColor whiteColor];
    
    [contentStackView addArrangedSubview:textLabel];
    
    self.provinsiLabel = [UILabel new];
    self.kabKotaLabel = [UILabel new];
    self.nikLabel = [UILabel new];
    self.namaLabel = [UILabel new];
    self.tempatLahirLabel = [UILabel new];
    self.tanggalLahirLabel = [UILabel new];
    self.jenisKelaminLabel = [UILabel new];
    self.goldarLabel = [UILabel new];
    self.alamatLabel = [UILabel new];
    self.rtLabel = [UILabel new];
    self.rwLabel = [UILabel new];
    self.kelurahanLabel = [UILabel new];
    self.kecamatanLabel = [UILabel new];
    self.agamaLabel = [UILabel new];
    self.statusPerkawinanLabel = [UILabel new];
    self.pekerjaanLabel = [UILabel new];
    self.kewarganegaraanLabel = [UILabel new];
    self.berlakuHinggaLabel = [UILabel new];
    
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Provinsi" label:self.provinsiLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Kabupaten/Kota" label:self.kabKotaLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"NIK" label:self.nikLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Nama Lengkap" label:self.namaLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Tempat Lahir" label:self.tempatLahirLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Tanggal Lahir" label:self.tanggalLahirLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Jenis Kelamin" label:self.jenisKelaminLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Golongan Darah" label:self.goldarLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Alamat" label:self.alamatLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"RT" label:self.rtLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"RW" label:self.rwLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Kelurahan/Desa" label:self.kelurahanLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Kecamatan" label:self.kecamatanLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Agama" label:self.agamaLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Status Perkawinan" label:self.statusPerkawinanLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Pekerjaan" label:self.pekerjaanLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"KewargaNegaraan" label:self.kewarganegaraanLabel]];
    [contentStackView addArrangedSubview:[self addViewForLabel:@"Berlaku Hingga" label:self.berlakuHinggaLabel]];
    
    UIView *secondSeparator = [UIView new];
    secondSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [contentStackView addArrangedSubview:secondSeparator];
    [secondSeparator.heightAnchor constraintEqualToConstant:16].active = YES;
    
    UIButton *nextButton = [UIButton new];
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.layer.cornerRadius = 24;
    nextButton.layer.masksToBounds = true;
    nextButton.translatesAutoresizingMaskIntoConstraints = false;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextButton setTitle:@"Konfirmasi Ulang" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextTapped) forControlEvents:UIControlEventTouchUpInside];
    [contentStackView addArrangedSubview:nextButton];
    [nextButton.heightAnchor constraintEqualToConstant:48].active = true;
}

- (void)setupData {
    self.provinsiLabel.text = self.ktpData.provinsi;
    self.kabKotaLabel.text = self.ktpData.kabkota;
    self.nikLabel.text = self.ktpData.NIK;
    self.namaLabel.text = self.ktpData.nama;
    self.tempatLahirLabel.text = self.ktpData.tempatLahir;
    self.tanggalLahirLabel.text = self.ktpData.tanggalLahir;
    self.jenisKelaminLabel.text = self.ktpData.jenisKelamin;
    self.goldarLabel.text = self.ktpData.golDarah;
    self.alamatLabel.text = self.ktpData.alamat;
    self.rtLabel.text = self.ktpData.rt;
    self.rwLabel.text = self.ktpData.rw;
    self.kelurahanLabel.text = self.ktpData.kelurahan;
    self.kecamatanLabel.text = self.ktpData.kecamatan;
    self.agamaLabel.text = self.ktpData.agama;
    self.statusPerkawinanLabel.text = self.ktpData.statusPerkawinan;
    self.pekerjaanLabel.text = self.ktpData.pekerjaan;
    self.kewarganegaraanLabel.text = self.ktpData.kewarganegaraan;
    self.berlakuHinggaLabel.text = self.ktpData.berlakuHingga;
}

- (UIStackView *)addViewForLabel:(NSString *)title label:(UILabel *)label {
    UIStackView *stackView = [UIStackView new];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 8;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    [stackView addArrangedSubview:titleLabel];
    
    UIStackView *labelStackView = [UIStackView new];
    labelStackView.backgroundColor = [MOIUtils colorWithHexString:@"CCCCCC"];
    labelStackView.layoutMarginsRelativeArrangement = YES;
    labelStackView.layer.cornerRadius = 4;
    labelStackView.layer.masksToBounds = YES;
    labelStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(12, 16, 12, 16);
    
    label.font = [UIFont systemFontOfSize:14];
    [labelStackView addArrangedSubview:label];
    [stackView addArrangedSubview:labelStackView];
    
    return stackView;
}

-(void)nextTapped {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ktp.png"];
    
    [UIImageJPEGRepresentation(self.ktpImage, 1) writeToFile:filePath atomically:YES];
    
    MNCOCRIdentifierResult *result = [MNCOCRIdentifierResult new];
    result.isSuccess = YES;
    result.errorMessage = @"Success";
    result.imagePath = filePath;
    result.ktp = self.ktpData;
    
    [self.resultDelegate ocrResult:result];
    [self.dissmissDelegate dismiss];
    [self backTapped];
}

- (void)backTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
