//
//  MOIKTPEnums.h
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum BloodType {
    a,
    aPlus,
    aMin,
    b,
    bPlus,
    bMin,
    ab,
    abPlus,
    abMin,
    o,
    oPlus,
    oMin,
    undefined
} BloodType;

typedef enum GenderType {
    male,
    female
} GenderType;

typedef enum MarriageType {
    belumKawin,
    kawin,
    ceraiHidup,
    ceraiMati
} MarriageType;

typedef enum ReligionType {
    islam,
    kristen,
    katolik,
    budha,
    hindu,
    konghuchu
} ReligionType;

@interface MOIKTPEnums : NSObject

+ (NSString *)formatBloodToString:(BloodType)bloodType;
+ (NSString *)formatGenderToString:(GenderType)genderType;
+ (NSString *)formatMarriageToString:(MarriageType)marriageType;
+ (NSString *)formatReligionToString:(ReligionType)religionType;

@end

NS_ASSUME_NONNULL_END
