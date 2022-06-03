//
//  MOIKTPEnums.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIKTPEnums.h"

@implementation MOIKTPEnums

+ (NSString *)formatBloodToString:(BloodType)bloodType {
    NSString *result = nil;
    
    switch (bloodType) {
        case a:
            result = @"A";
            break;
        case aPlus:
            result = @"A+";
            break;
        case aMin:
            result = @"A-";
            break;
        case b:
            result = @"B";
            break;
        case bPlus:
            result = @"B+";
            break;
        case bMin:
            result = @"B-";
            break;
        case ab:
            result = @"AB";
            break;
        case abPlus:
            result = @"AB+";
            break;
        case abMin:
            result = @"AB-";
            break;
        case o:
            result = @"O";
            break;
        case oPlus:
            result = @"O+";
            break;
        case oMin:
            result = @"O-";
            break;
        case undefined:
            result = @"-";
            break;
    }
    
    return result;
}

+ (NSString *)formatGenderToString:(GenderType)genderType {
    NSString *result = nil;
    
    switch(genderType) {
        case male:
            result = @"LAKI-LAKI";
            break;
        case female:
            result = @"PEREMPUAN";
            break;
    }
    
    return result;
}

+ (NSString *)formatMarriageToString:(MarriageType)marriageType {
    NSString *result = nil;
    
    switch(marriageType) {
        case belumKawin:
            result = @"BELUM KAWIN";
            break;
        case kawin:
            result = @"KAWIN";
            break;
        case ceraiHidup:
            result = @"CERAI HIDUP";
            break;
        case ceraiMati:
            result = @"CERAI MATI";
            break;
    }
    
    return result;
}

+ (NSString *)formatReligionToString:(ReligionType)religionType {
    NSString *result = nil;
    
    switch (religionType) {
        case islam:
            result = @"ISLAM";
            break;
        case kristen:
            result = @"KRISTEN";
            break;
        case katolik:
            result = @"KATOLIK";
            break;
        case budha:
            result = @"BUDHA";
            break;
        case hindu:
            result = @"HINDU";
            break;
        case konghuchu:
            result = @"KONGHUCHU";
            break;
    }
    
    return result;
}

@end
