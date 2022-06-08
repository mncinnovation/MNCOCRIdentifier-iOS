//
//  MOICorrectionViewController.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOICorrectionViewController.h"
#import "MOIVerificationViewController.h"
#import "MOIKTPEnums.h"
#import "MOITextFieldView.h"

@interface MOICorrectionViewController () <UIPickerViewDelegate, UIPickerViewDataSource, MOIDismissDelegate, MOITextFieldDelegate> {
    NSBundle *bundle;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MOITextFieldView *provinsiTextField;
@property (strong, nonatomic) MOITextFieldView *kabKotaTextField;
@property (strong, nonatomic) MOITextFieldView *nikTextField;
@property (strong, nonatomic) MOITextFieldView *namaTextField;
@property (strong, nonatomic) MOITextFieldView *tempatLahirTextField;
@property (strong, nonatomic) MOITextFieldView *tanggalLahirTextField;
@property (strong, nonatomic) MOITextFieldView *jenisKelaminTextField;
@property (strong, nonatomic) MOITextFieldView *goldarTextField;
@property (strong, nonatomic) MOITextFieldView *alamatTextField;
@property (strong, nonatomic) MOITextFieldView *rtTextField;
@property (strong, nonatomic) MOITextFieldView *rwTextField;
@property (strong, nonatomic) MOITextFieldView *kelurahanTextField;
@property (strong, nonatomic) MOITextFieldView *kecamatanTextField;
@property (strong, nonatomic) MOITextFieldView *agamaTextField;
@property (strong, nonatomic) MOITextFieldView *statusPerkawinanTextField;
@property (strong, nonatomic) MOITextFieldView *pekerjaanTextField;
@property (strong, nonatomic) MOITextFieldView *kewarganegaraanTextField;
@property (strong, nonatomic) MOITextFieldView *berlakuHinggaTextField;
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
    
    self.provinsiTextField = [MOITextFieldView new];
    self.provinsiTextField.title = @"Provinsi";
    self.provinsiTextField.delegate = self;
    [contentStackView addArrangedSubview:self.provinsiTextField];
    
    self.kabKotaTextField = [MOITextFieldView new];
    self.kabKotaTextField.title = @"Provinsi";
    self.kabKotaTextField.delegate = self;
    [contentStackView addArrangedSubview:self.kabKotaTextField];
    
    self.nikTextField = [MOITextFieldView new];
    self.nikTextField.title = @"NIK";
    self.nikTextField.delegate = self;
    [contentStackView addArrangedSubview:self.nikTextField];
    
    self.namaTextField = [MOITextFieldView new];
    self.namaTextField.title = @"Nama Lengkap";
    self.namaTextField.delegate = self;
    [contentStackView addArrangedSubview:self.namaTextField];
    
    self.tempatLahirTextField = [MOITextFieldView new];
    self.tempatLahirTextField.title = @"Tempat Lahir";
    self.tempatLahirTextField.delegate = self;
    [contentStackView addArrangedSubview:self.tempatLahirTextField];
    
    
    self.tanggalLahirTextField = [MOITextFieldView new];
    self.tanggalLahirTextField.title = @"Tanggal Lahir";
    self.tanggalLahirTextField.delegate = self;
    [contentStackView addArrangedSubview:self.tanggalLahirTextField];
    
    self.jenisKelaminTextField = [MOITextFieldView new];
    self.jenisKelaminTextField.title = @"Jenis Kelamin";
    self.jenisKelaminTextField.delegate = self;
    [contentStackView addArrangedSubview:self.jenisKelaminTextField];
    
    self.goldarTextField = [MOITextFieldView new];
    self.goldarTextField.title = @"Golongan Darah";
    self.goldarTextField.delegate = self;
    [contentStackView addArrangedSubview:self.goldarTextField];
    
    self.alamatTextField = [MOITextFieldView new];
    self.alamatTextField.title = @"Alamat";
    self.alamatTextField.delegate = self;
    [contentStackView addArrangedSubview:self.alamatTextField];
    
    self.rtTextField = [MOITextFieldView new];
    self.rtTextField.title = @"RT";
    self.rtTextField.delegate = self;
    [contentStackView addArrangedSubview:self.rtTextField];
    
    self.rwTextField = [MOITextFieldView new];
    self.rwTextField.title = @"RW";
    self.rwTextField.delegate = self;
    [contentStackView addArrangedSubview:self.rwTextField];
    
    self.kelurahanTextField = [MOITextFieldView new];
    self.kelurahanTextField.title = @"Kelurahan/Desa";
    self.kelurahanTextField.delegate = self;
    [contentStackView addArrangedSubview:self.kelurahanTextField];
    
    self.kecamatanTextField = [MOITextFieldView new];
    self.kecamatanTextField.title = @"Kecamatan";
    self.kecamatanTextField.delegate = self;
    [contentStackView addArrangedSubview:self.kecamatanTextField];
    
    self.agamaTextField = [MOITextFieldView new];
    self.agamaTextField.title = @"Agama";
    self.agamaTextField.delegate = self;
    [contentStackView addArrangedSubview:self.agamaTextField];
    
    self.statusPerkawinanTextField = [MOITextFieldView new];
    self.statusPerkawinanTextField.title = @"Status Perkawinan";
    self.statusPerkawinanTextField.delegate = self;
    [contentStackView addArrangedSubview:self.statusPerkawinanTextField];
    
    self.pekerjaanTextField = [MOITextFieldView new];
    self.pekerjaanTextField.title = @"Pekerjaan";
    self.pekerjaanTextField.delegate = self;
    [contentStackView addArrangedSubview:self.pekerjaanTextField];
    
    self.kewarganegaraanTextField = [MOITextFieldView new];
    self.kewarganegaraanTextField.title = @"Kewarganegaraan";
    self.kewarganegaraanTextField.delegate = self;
    [contentStackView addArrangedSubview:self.kewarganegaraanTextField];
    
    self.berlakuHinggaTextField = [MOITextFieldView new];
    self.berlakuHinggaTextField.title = @"Berlaku Hingga";
    self.berlakuHinggaTextField.delegate = self;
    [contentStackView addArrangedSubview:self.berlakuHinggaTextField];
    
    self.nikTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.rtTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.rwTextField.keyboardType = UIKeyboardTypeNumberPad;
    
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
    [self.jenisKelaminTextField dismissFocus];
    self.ktpData.jenisKelamin = temporaryGender;
    self.jenisKelaminTextField.text = temporaryGender;
}

- (void)finishPickGolonganDarah {
    [self.goldarTextField dismissFocus];
    self.ktpData.golDarah = temporaryBlood;
    self.goldarTextField.text = temporaryBlood;
}

- (void)finishPickStatusPerkawinan {
    [self.statusPerkawinanTextField dismissFocus];
    self.ktpData.statusPerkawinan = temporaryMarriage;
    self.statusPerkawinanTextField.text = temporaryMarriage;
}

- (void)finishPickTanggalLahir {
    [self.tanggalLahirTextField dismissFocus];
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *finalDate = [dateFormat stringFromDate:temporaryBirthDate];
    self.tanggalLahirTextField.text = finalDate;
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

- (void)textFieldReturn:(MOITextFieldView *)textFieldView {
    [textFieldView dismissFocus];
    if ([textFieldView isEqual:self.provinsiTextField]) {
        [self.kabKotaTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.kabKotaTextField]) {
        [self.nikTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.nikTextField]) {
        [self.namaTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.namaTextField]) {
        [self.tempatLahirTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.tempatLahirTextField]) {
        [self.tanggalLahirTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.tanggalLahirTextField]) {
        [self.jenisKelaminTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.jenisKelaminTextField]) {
        [self.goldarTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.goldarTextField]) {
        [self.alamatTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.alamatTextField]) {
        [self.rtTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.rtTextField]) {
        [self.rwTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.rwTextField]) {
        [self.kelurahanTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.kelurahanTextField]) {
        [self.kecamatanTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.kecamatanTextField]) {
        [self.agamaTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.agamaTextField]) {
        [self.statusPerkawinanTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.statusPerkawinanTextField]) {
        [self.pekerjaanTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.pekerjaanTextField]) {
        [self.kewarganegaraanTextField setAsFocus];
    }
    
    if ([textFieldView isEqual:self.kewarganegaraanTextField]) {
        [self.berlakuHinggaTextField setAsFocus];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSRange lowercaseCharRange = [string rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    
    if (lowercaseCharRange.location != NSNotFound) {
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
        return NO;
    }
    
    return YES;
}

- (void)backTapped {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextTapped {
    if ([self isCompleteData]) {
        [self.ktpData trimAllWhiteSpace];
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
    MOITextFieldView *errorTextField = nil;
    
    [self.provinsiTextField setError:nil];
    [self.kabKotaTextField setError:nil];
    [self.nikTextField setError:nil];
    [self.namaTextField setError:nil];
    [self.tempatLahirTextField setError:nil];
    [self.tanggalLahirTextField setError:nil];
    [self.jenisKelaminTextField setError:nil];
    [self.goldarTextField setError:nil];
    [self.alamatTextField setError:nil];
    [self.rtTextField setError:nil];
    [self.rwTextField setError:nil];
    [self.kelurahanTextField setError:nil];
    [self.kecamatanTextField setError:nil];
    [self.agamaTextField setError:nil];
    [self.statusPerkawinanTextField setError:nil];
    [self.pekerjaanTextField setError:nil];
    [self.kewarganegaraanTextField setError:nil];
    [self.berlakuHinggaTextField setError:nil];
    
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
        [self.provinsiTextField setError:@"Provinsi tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.provinsiTextField;
        }
    }
    
    if (self.ktpData.kabkota == nil || [self.ktpData.kabkota  isEqual: @""]) {
        result = NO;
        [self.kabKotaTextField setError:@"Kabupaten/Kota tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.kabKotaTextField;
        }
    }
    
    if (self.ktpData.NIK == nil || [self.ktpData.NIK  isEqual: @""]) {
        result = NO;
        [self.nikTextField setError:@"NIK tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.nikTextField;
        }
    }
    
    if (self.ktpData.nama == nil || [self.ktpData.nama  isEqual: @""]) {
        result = NO;
        [self.namaTextField setError:@"Nama tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.namaTextField;
        }
    }
    
    if (self.ktpData.tempatLahir == nil || [self.ktpData.tempatLahir  isEqual: @""]) {
        result = NO;
        [self.tempatLahirTextField setError:@"Tempat lahir tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.tempatLahirTextField;
        }
    }
    
    if (self.ktpData.tanggalLahir == nil || [self.ktpData.tanggalLahir  isEqual: @""]) {
        result = NO;
        [self.tanggalLahirTextField setError:@"Tanggal lahir tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.tanggalLahirTextField;
        }
    }
    
    if (self.ktpData.jenisKelamin == nil || [self.ktpData.jenisKelamin  isEqual: @""]) {
        result = NO;
        [self.jenisKelaminTextField setError:@"Jenis kelamin tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.jenisKelaminTextField;
        }
    }
    
    if (self.ktpData.golDarah == nil || [self.ktpData.golDarah  isEqual: @""]) {
        result = NO;
        [self.goldarTextField setError:@"Golongan darah tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.goldarTextField;
        }
    }
    
    if (self.ktpData.alamat == nil || [self.ktpData.alamat  isEqual: @""]) {
        result = NO;
        [self.alamatTextField setError:@"Alamat tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.alamatTextField;
        }
    }
    
    if (self.ktpData.rt == nil || [self.ktpData.rt  isEqual: @""]) {
        result = NO;
        [self.rtTextField setError:@"RT tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.rtTextField;
        }
    }
    
    if (self.ktpData.rw == nil || [self.ktpData.rw  isEqual: @""]) {
        result = NO;
        [self.rwTextField setError:@"RW tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.rwTextField;
        }
    }
    
    if (self.ktpData.kelurahan == nil || [self.ktpData.kelurahan  isEqual: @""]) {
        result = NO;
        [self.kelurahanTextField setError:@"Kelurahan tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.kelurahanTextField;
        }
    }
    
    if (self.ktpData.kecamatan == nil || [self.ktpData.kecamatan  isEqual: @""]) {
        result = NO;
        [self.kecamatanTextField setError:@"Kecamatan tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.kecamatanTextField;
        }
    }
    
    if (self.ktpData.agama == nil || [self.ktpData.agama  isEqual: @""]) {
        result = NO;
        [self.agamaTextField setError:@"Agama tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.agamaTextField;
        }
    }
    
    if (self.ktpData.statusPerkawinan == nil || [self.ktpData.statusPerkawinan  isEqual: @""]) {
        result = NO;
        [self.statusPerkawinanTextField setError:@"Status perkawinan tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.statusPerkawinanTextField;
        }
    }
    
    if (self.ktpData.pekerjaan == nil || [self.ktpData.pekerjaan  isEqual: @""]) {
        result = NO;
        [self.pekerjaanTextField setError:@"Pekerjaan tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.pekerjaanTextField;
        }
    }
    
    if (self.ktpData.kewarganegaraan == nil || [self.ktpData.kewarganegaraan isEqual:@""]) {
        result = NO;
        [self.kewarganegaraanTextField setError:@"Kewarganegaraan tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.kewarganegaraanTextField;
        }
    }
    
    if (self.ktpData.berlakuHingga == nil || [self.ktpData.berlakuHingga  isEqual: @""]) {
        result = NO;
        [self.berlakuHinggaTextField setError:@"Berlaku hingga tidak boleh kosong"];
        if (errorTextField == nil) {
            errorTextField = self.berlakuHinggaTextField;
        }
    }
    
    if (errorTextField != nil) {
        [errorTextField setAsFocus];
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
