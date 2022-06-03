//
//  MOICorrectionViewController.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOICorrectionViewController.h"
#import "MOIVerificationViewController.h"
#import "MOIKTPEnums.h"

@interface MOICorrectionViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MOIDismissDelegate> {
    NSBundle *bundle;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *provinsiTextField;
@property (strong, nonatomic) UITextField *kabKotaTextField;
@property (strong, nonatomic) UITextField *nikTextField;
@property (strong, nonatomic) UITextField *namaTextField;
@property (strong, nonatomic) UITextField *tempatLahirTextField;
@property (strong, nonatomic) UITextField *tanggalLahirTextField;
@property (strong, nonatomic) UITextField *jenisKelaminTextField;
@property (strong, nonatomic) UITextField *goldarTextField;
@property (strong, nonatomic) UITextField *alamatTextField;
@property (strong, nonatomic) UITextField *rtTextField;
@property (strong, nonatomic) UITextField *rwTextField;
@property (strong, nonatomic) UITextField *kelurahanTextField;
@property (strong, nonatomic) UITextField *kecamatanTextField;
@property (strong, nonatomic) UITextField *agamaTextField;
@property (strong, nonatomic) UITextField *statusPerkawinanTextField;
@property (strong, nonatomic) UITextField *pekerjaanTextField;
@property (strong, nonatomic) UITextField *kewarganegaraanTextField;
@property (strong, nonatomic) UITextField *berlakuHinggaTextField;
@property (strong, nonatomic) UIPickerView *goldarPicker;
@property (strong, nonatomic) UIPickerView *jenisKelaminPicker;
@property (strong, nonatomic) UIPickerView *statusPerkawinanPicker;
@property (strong, nonatomic) UIDatePicker *tanggalLahirPicker;
@property (strong, nonatomic) NSArray *bloods;
@property (strong, nonatomic) NSArray *genders;
@property (strong, nonatomic) NSArray *marriageStatus;
@property (strong, nonatomic) NSArray *religions;
@property (nonatomic) BloodType *currentBlood;
@property (nonatomic) GenderType *currentGender;
@property (nonatomic) MarriageType *currentMarriage;
@property (nonatomic) ReligionType *currentReligion;

@end

NSString *temporaryBlood;
NSString *temporaryGender;
NSString *temporaryMarriage;
NSDate *temporaryBirthDate;

@implementation MOICorrectionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        bundle = [NSBundle bundleWithIdentifier:@"MNCIdentifier.MNCOCRIdentifier"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bloods = @[@(a), @(aPlus), @(aMin), @(b), @(bPlus), @(bMin), @(ab), @(abPlus), @(abMin), @(o), @(oPlus), @(oMin), @(undefined)];
    self.genders = @[@(male), @(female)];
    self.marriageStatus = @[@(belumKawin), @(kawin), @(ceraiHidup), @(ceraiMati)];
    self.religions = @[@(islam), @(kristen), @(katolik), @(budha), @(hindu), @(konghuchu)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardCameUp:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWentAway:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped:)];
    
    [self setupView];
    [self setupData];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewDidTapped:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)keyboardCameUp:(NSNotification *)notification {
    
    NSValue *keyboardFrame = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = keyboardFrame.CGRectValue.size.height;
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, keyboardHeight, 0)];
}

- (void)keyboardWentAway:(NSNotification *)notification {
    
    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor blackColor];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.scrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.scrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    
    UIStackView *contentStackView = [UIStackView new];
    contentStackView.spacing = 24;
    contentStackView.alignment = UIStackViewAlignmentFill;
    contentStackView.axis = UILayoutConstraintAxisVertical;
    contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    contentStackView.layoutMarginsRelativeArrangement = YES;
    contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(14, 20, 58, 20);
    [self.scrollView addSubview:contentStackView];
    [contentStackView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor].active = YES;
    [contentStackView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor].active = YES;
    [contentStackView.leftAnchor constraintEqualToAnchor:self.scrollView.leftAnchor].active = YES;
    [contentStackView.rightAnchor constraintEqualToAnchor:self.scrollView.rightAnchor].active = YES;
    [contentStackView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor].active = YES;
    
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
    
    [contentStackView addArrangedSubview:backStackView];
    
    UIView *firstSeparator = [UIView new];
    firstSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [contentStackView addArrangedSubview:firstSeparator];
    [firstSeparator.heightAnchor constraintEqualToConstant:1].active = YES;
    
    self.provinsiTextField = [UITextField new];
    self.kabKotaTextField = [UITextField new];
    self.nikTextField = [UITextField new];
    self.namaTextField = [UITextField new];
    self.tempatLahirTextField = [UITextField new];
    self.tanggalLahirTextField = [UITextField new];
    self.jenisKelaminTextField = [UITextField new];
    self.goldarTextField = [UITextField new];
    self.alamatTextField = [UITextField new];
    self.rtTextField = [UITextField new];
    self.rwTextField = [UITextField new];
    self.kelurahanTextField = [UITextField new];
    self.kecamatanTextField = [UITextField new];
    self.agamaTextField = [UITextField new];
    self.statusPerkawinanTextField = [UITextField new];
    self.pekerjaanTextField = [UITextField new];
    self.kewarganegaraanTextField = [UITextField new];
    self.berlakuHinggaTextField = [UITextField new];
    
    self.nikTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.rtTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.rwTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Provinsi" textField:self.provinsiTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Kabupaten/Kota" textField:self.kabKotaTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"NIK" textField:self.nikTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Nama Lengkap" textField:self.namaTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Tempat Lahir" textField:self.tempatLahirTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Tanggal Lahir" textField:self.tanggalLahirTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Jenis Kelamin" textField:self.jenisKelaminTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Golongan Darah" textField:self.goldarTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Alamat" textField:self.alamatTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"RT" textField:self.rtTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"RW" textField:self.rwTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Kelurahan/Desa" textField:self.kelurahanTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Kecamatan" textField:self.kecamatanTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Agama" textField:self.agamaTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Status Perkawinan" textField:self.statusPerkawinanTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Pekerjaan" textField:self.pekerjaanTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Kewarganegaraan" textField:self.kewarganegaraanTextField]];
    [contentStackView addArrangedSubview:[self addViewForTextField:@"Berlaku Hingga" textField:self.berlakuHinggaTextField]];
    
    UIView *secondSeparator = [UIView new];
    secondSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    [contentStackView addArrangedSubview:secondSeparator];
    [secondSeparator.heightAnchor constraintEqualToConstant:26].active = YES;
    
    UIButton *nextButton = [UIButton new];
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.layer.cornerRadius = 24;
    nextButton.layer.masksToBounds = YES;
    nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [nextButton setTitle:@"Lanjutkan" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextTapped) forControlEvents:UIControlEventTouchUpInside];
    [contentStackView addArrangedSubview:nextButton];
    [nextButton.heightAnchor constraintEqualToConstant:48].active = YES;
    
    self.jenisKelaminPicker = [UIPickerView new];
    self.jenisKelaminPicker.delegate = self;
    self.jenisKelaminPicker.dataSource = self;
    self.jenisKelaminPicker.tag = 1;
    
    UIToolbar *jenisKelaminToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneJenisKelaminButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishPickJenisKelamin)];
    [jenisKelaminToolbar setItems:[NSArray arrayWithObject:doneJenisKelaminButton] animated:NO];
    self.jenisKelaminTextField.inputAccessoryView = jenisKelaminToolbar;
    self.jenisKelaminTextField.inputView = self.jenisKelaminPicker;
    
    self.goldarPicker = [UIPickerView new];
    self.goldarPicker.delegate = self;
    self.goldarPicker.dataSource = self;
    self.goldarPicker.tag = 2;
    
    UIToolbar *goldarToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneGoldarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishPickGolonganDarah)];
    [goldarToolbar setItems:[NSArray arrayWithObject:doneGoldarButton] animated:NO];
    self.goldarTextField.inputAccessoryView = goldarToolbar;
    self.goldarTextField.inputView = self.goldarPicker;
    
    self.statusPerkawinanPicker = [UIPickerView new];
    self.statusPerkawinanPicker.delegate = self;
    self.statusPerkawinanPicker.dataSource = self;
    self.statusPerkawinanPicker.tag = 3;
    
    UIToolbar *statusPerkawinanToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneStatusPerkawinanButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishPickStatusPerkawinan)];
    [statusPerkawinanToolbar setItems:[NSArray arrayWithObject:doneStatusPerkawinanButton] animated:NO];
    self.statusPerkawinanTextField.inputAccessoryView = statusPerkawinanToolbar;
    self.statusPerkawinanTextField.inputView = self.statusPerkawinanPicker;
    
    self.tanggalLahirPicker = [UIDatePicker new];
    self.tanggalLahirPicker.datePickerMode = UIDatePickerModeDate;
    if (@available(iOS 14.0, *)) {
        self.tanggalLahirPicker.preferredDatePickerStyle = UIDatePickerStyleInline;
    } else {
        // Fallback on earlier versions
    }
    self.tanggalLahirPicker.maximumDate = [NSDate new];
    UIToolbar *tanggalLahirToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *doneTanggalLahirButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishPickTanggalLahir)];
    [tanggalLahirToolbar setItems:[NSArray arrayWithObject:doneTanggalLahirButton] animated:NO];
    [self.tanggalLahirPicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    self.tanggalLahirTextField.inputAccessoryView = tanggalLahirToolbar;
    self.tanggalLahirTextField.inputView = self.tanggalLahirPicker;
}

- (void)dueDateChanged:(UIDatePicker *)sender {
    temporaryBirthDate = [sender date];
}

- (void)finishPickJenisKelamin {
    [self.jenisKelaminTextField resignFirstResponder];
    self.ktpData.jenisKelamin = temporaryGender;
    self.jenisKelaminTextField.text = temporaryGender;
}

- (void)finishPickGolonganDarah {
    [self.goldarTextField resignFirstResponder];
    self.ktpData.golDarah = temporaryBlood;
    self.goldarTextField.text = temporaryBlood;
}

- (void)finishPickStatusPerkawinan {
    [self.statusPerkawinanTextField resignFirstResponder];
    self.ktpData.statusPerkawinan = temporaryMarriage;
    self.statusPerkawinanTextField.text = temporaryMarriage;
}

- (void)finishPickTanggalLahir {
    [self.tanggalLahirTextField resignFirstResponder];
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *finalDate = [dateFormat stringFromDate:temporaryBirthDate];
    self.tanggalLahirTextField.text = finalDate;
}

- (UIStackView *)addViewForTextField:(NSString *)title textField:(UITextField *)textField {
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
    
    UIStackView *textFieldStackView = [UIStackView new];
    textFieldStackView.backgroundColor = [UIColor whiteColor];
    textFieldStackView.layoutMarginsRelativeArrangement = YES;
    textFieldStackView.layer.cornerRadius = 4;
    textFieldStackView.layer.masksToBounds = YES;
    textFieldStackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(12, 16, 12, 16);
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyNext;
    
    UIImage *pencilImage = [UIImage imageNamed:@"ic_pencil" inBundle:bundle compatibleWithTraitCollection:nil];
    UIImageView *pencilImageView = [UIImageView new];
    pencilImageView.image = pencilImage;
    pencilImageView.contentMode = UIViewContentModeScaleAspectFit;
    pencilImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [textFieldStackView addArrangedSubview:textField];
    [textFieldStackView addArrangedSubview:pencilImageView];
    [pencilImageView.heightAnchor constraintEqualToConstant:18].active = YES;
    [pencilImageView.widthAnchor constraintEqualToConstant:18].active = YES;
    
    [stackView addArrangedSubview:textFieldStackView];
    
    return stackView;
}

- (void)setupData {
    self.provinsiTextField.text = self.ktpData.provinsi;
    self.kabKotaTextField.text = self.ktpData.kabkota;
    self.nikTextField.text = self.ktpData.NIK;
    self.namaTextField.text = self.ktpData.nama;
    self.tempatLahirTextField.text = self.ktpData.tempatLahir;
    self.tanggalLahirTextField.text = self.ktpData.tanggalLahir;
    self.jenisKelaminTextField.text = self.ktpData.jenisKelamin;
    self.goldarTextField.text = self.ktpData.golDarah;
    self.alamatTextField.text = self.ktpData.alamat;
    self.rtTextField.text = self.ktpData.rt;
    self.rwTextField.text = self.ktpData.rw;
    self.kelurahanTextField.text = self.ktpData.kelurahan;
    self.kecamatanTextField.text = self.ktpData.kecamatan;
    self.agamaTextField.text = self.ktpData.agama;
    self.statusPerkawinanTextField.text = self.ktpData.statusPerkawinan;
    self.pekerjaanTextField.text = self.ktpData.pekerjaan;
    self.berlakuHinggaTextField.text = self.ktpData.berlakuHingga;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([textField isEqual:self.provinsiTextField]) {
        [self.kabKotaTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.kabKotaTextField]) {
        [self.nikTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.nikTextField]) {
        [self.namaTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.namaTextField]) {
        [self.tempatLahirTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.tempatLahirTextField]) {
        [self.tanggalLahirTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.tanggalLahirTextField]) {
        [self.jenisKelaminTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.jenisKelaminTextField]) {
        [self.goldarTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.goldarTextField]) {
        [self.alamatTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.alamatTextField]) {
        [self.rtTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.rtTextField]) {
        [self.rwTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.rwTextField]) {
        [self.kelurahanTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.kelurahanTextField]) {
        [self.kecamatanTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.kecamatanTextField]) {
        [self.agamaTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.agamaTextField]) {
        [self.statusPerkawinanTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.statusPerkawinanTextField]) {
        [self.pekerjaanTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.pekerjaanTextField]) {
        [self.kewarganegaraanTextField becomeFirstResponder];
    }
    
    if ([textField isEqual:self.kewarganegaraanTextField]) {
        [self.berlakuHinggaTextField becomeFirstResponder];
    }
    return YES;
}

- (void)backTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextTapped {
    if ([self isCompleteData]) {
        MOIVerificationViewController *verificationController = [[MOIVerificationViewController alloc] initWithNibName:nil bundle:bundle];
        verificationController.modalPresentationStyle = UIModalPresentationFullScreen;
        verificationController.ktpData = self.ktpData;
        verificationController.dissmissDelegate = self;
        verificationController.resultDelegate = self.resultDelegate;
        verificationController.ktpImage = self.ktpImage;
        [self presentViewController:verificationController animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Data Verification" message:@"Please Complete your data" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *closeButton = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:closeButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (BOOL)isCompleteData {
    BOOL result = YES;
    self.ktpData = [MOIKTPDataModel new];
    self.ktpData.provinsi = self.provinsiTextField.text;
    self.ktpData.kabkota = self.kabKotaTextField.text;
    self.ktpData.NIK = self.nikTextField.text;
    self.ktpData.nama = self.namaTextField.text;
    self.ktpData.tempatLahir = self.tempatLahirTextField.text;
    self.ktpData.tanggalLahir = self.tanggalLahirTextField.text;
    self.ktpData.jenisKelamin = self.jenisKelaminTextField.text;
    self.ktpData.golDarah = self.goldarTextField.text;
    self.ktpData.alamat = self.alamatTextField.text;
    self.ktpData.rt = self.rtTextField.text;
    self.ktpData.rw = self.rwTextField.text;
    self.ktpData.kelurahan = self.kelurahanTextField.text;
    self.ktpData.kecamatan = self.kecamatanTextField.text;
    self.ktpData.agama = self.agamaTextField.text;
    self.ktpData.statusPerkawinan = self.statusPerkawinanTextField.text;
    self.ktpData.pekerjaan = self.pekerjaanTextField.text;
    self.ktpData.kewarganegaraan = self.kewarganegaraanTextField.text;
    self.ktpData.berlakuHingga = self.berlakuHinggaTextField.text;
    
    if (self.ktpData.provinsi == nil || [self.ktpData.provinsi  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.kabkota == nil || [self.ktpData.kabkota  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.NIK == nil || [self.ktpData.NIK  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.nama == nil || [self.ktpData.nama  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.tempatLahir == nil || [self.ktpData.tempatLahir  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.tanggalLahir == nil || [self.ktpData.tanggalLahir  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.jenisKelamin == nil || [self.ktpData.jenisKelamin  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.golDarah == nil || [self.ktpData.golDarah  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.alamat == nil || [self.ktpData.alamat  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.rt == nil || [self.ktpData.rt  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.rw == nil || [self.ktpData.rw  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.kelurahan == nil || [self.ktpData.kelurahan  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.kecamatan == nil || [self.ktpData.kecamatan  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.agama == nil || [self.ktpData.agama  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.statusPerkawinan == nil || [self.ktpData.statusPerkawinan  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.pekerjaan == nil || [self.ktpData.pekerjaan  isEqual: @""]) {
        result = NO;
    }
    
    if (self.ktpData.kewarganegaraan == nil || [self.ktpData.kewarganegaraan isEqual:@""]) {
        result = NO;
    }
    
    if (self.ktpData.berlakuHingga == nil || [self.ktpData.berlakuHingga  isEqual: @""]) {
        result = NO;
    }
    
    return result;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return self.genders.count;
    } else if (pickerView.tag == 2) {
        return self.bloods.count;
    } else if (pickerView.tag == 3) {
        return self.marriageStatus.count;
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return [MOIKTPEnums formatGenderToString:[self.genders[row] intValue]];
    } else if (pickerView.tag == 2) {
        return [MOIKTPEnums formatBloodToString:[self.bloods[row] intValue]];
    } else if (pickerView.tag == 3) {
        return [MOIKTPEnums formatMarriageToString:[self.marriageStatus[row] intValue]];
    } else {
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        temporaryGender = [MOIKTPEnums formatGenderToString:[self.genders[row] intValue]];
    } else if (pickerView.tag == 2) {
        temporaryBlood = [MOIKTPEnums formatBloodToString:[self.bloods[row] intValue]];
    } else if (pickerView.tag == 3) {
        temporaryMarriage = [MOIKTPEnums formatMarriageToString:[self.marriageStatus[row] intValue]];
    }
}

- (void)dismiss {
    [self.dismissDelegate dismiss];
    [self backTapped];
}

@end
