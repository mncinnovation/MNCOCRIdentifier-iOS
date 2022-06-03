//
//  MOIExtractKTPData.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIExtractKTPData.h"
#import "MOICommonTextModel.h"

@import MLKitVision;
@import MLKitTextRecognition;
@import MLKitTextRecognitionCommon;

@implementation MOIExtractKTPData

- (void)extract:(UIImage *)image completion:(ExtractKTPCallback)completion {
    UIImage *rotatedImage = [UIImage imageWithCGImage:image.CGImage
                                                scale:1.0
                                          orientation:UIImageOrientationRight];
    
    MLKVisionImage *visionImage = [[MLKVisionImage alloc] initWithImage:rotatedImage];
    visionImage.orientation = rotatedImage.imageOrientation;
    MLKTextRecognizer *textRecognizer = [MLKTextRecognizer textRecognizerWithOptions:[[MLKTextRecognizerOptions alloc] init]];
    [textRecognizer processImage:visionImage completion:^(MLKText * _Nullable text, NSError * _Nullable error) {
        if (error != nil || text == nil) {
            return;
        }
        
        MOIKTPDataModel *ktpData = [self extractData:text.blocks];
        CGFloat percentageCompletedData = [self percentageData:ktpData];
        completion(ktpData, percentageCompletedData);
    }];
}

- (CGFloat)percentageData:(MOIKTPDataModel *)ktpData {
    CGFloat count = 0;
    
    if (ktpData.provinsi != nil) {
        count++;
    }
    
    if (ktpData.kabkota != nil) {
        count++;
    }
    
    if (ktpData.NIK != nil) {
        count++;
    }
    
    if (ktpData.nama != nil) {
        count++;
    }
    
    if (ktpData.tempatLahir != nil) {
        count++;
    }
    
    if (ktpData.tanggalLahir != nil) {
        count++;
    }
    
    if (ktpData.golDarah != nil) {
        count++;
    }
    
    if (ktpData.alamat != nil) {
        count++;
    }
    
    if (ktpData.rt != nil) {
        count++;
    }
    
    if (ktpData.rw != nil) {
        count++;
    }
    
    if (ktpData.kelurahan != nil) {
        count++;
    }
    
    if (ktpData.kecamatan != nil) {
        count++;
    }
    
    if (ktpData.jenisKelamin != nil) {
        count++;
    }
    
    if (ktpData.agama != nil) {
        count++;
    }
    
    if (ktpData.statusPerkawinan != nil) {
        count++;
    }
    
    if (ktpData.pekerjaan != nil) {
        count++;
    }
    
    if (ktpData.kewarganegaraan != nil) {
        count++;
    }
    
    if (ktpData.berlakuHingga != nil) {
        count++;
    }
    
    return (count/18) * 100;
}

- (MOIKTPDataModel *)extractData:(NSArray *)textBlocks {
    MOIKTPDataModel *ktpData = [MOIKTPDataModel new];
    
    for (MLKTextBlock *textBlock in textBlocks) {
        for (MLKTextLine *line in textBlock.lines) {
            NSString *lineText = line.text;
            NSString *lowerLineText = [lineText lowercaseString];
            
            if ([lowerLineText containsString:@"provinsi"]) {
                ktpData.provinsi = [self cleanseString:lineText clean:@"PROVINSI"];
            }
            
            if ([lowerLineText containsString:@"kota"] || [lowerLineText containsString:@"kabupaten"] || [lowerLineText containsString:@"jakarta"]) {
                ktpData.kabkota = lineText;
            }
            
            if ([lowerLineText containsString:@"nik"]) {
                ktpData.NIK = [self filterNumberOnly:(line.elements.count > 1) ? line.elements.lastObject.text : [self findData:textBlocks line:line]];
            }
            
            if ([lowerLineText containsString:@"nama"]) {
                ktpData.nama = (line.elements.count > 1) ? [self cleanseString:lineText clean:@"Nama"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"tempat"] || [lowerLineText containsString:@"lahir"] || [lowerLineText containsString:@"tgl"]) {
                NSError *error = nil;
                NSRegularExpression *regexDate = [NSRegularExpression regularExpressionWithPattern:@"\\d\\d-\\d\\d-\\d\\d\\d\\d"
                                                                                       options:NSRegularExpressionCaseInsensitive error:&error];
                
                NSString *date = line.elements.lastObject.text;
                NSString *place = nil;
                
                NSInteger resultDate = [regexDate numberOfMatchesInString:date options:0 range:NSMakeRange(0, date.length)];
                
                if (resultDate > 0 && line.elements.count - 2 > 0) {
                    place = [self cleanseString:line.elements[line.elements.count - 2].text clean:@","];
                } else {
                    date = nil;
                    NSString *ttl = [self findData:textBlocks line:line];
                    NSRegularExpression *regexTTL = [NSRegularExpression regularExpressionWithPattern: @"[A-Z0-9-/ ]{3,}+"
                                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                                error:&error];
                    NSArray *regexArrayTTL = [regexTTL matchesInString:ttl options:0 range:NSMakeRange(0, ttl.length)];
                                        
                    if (regexArrayTTL > 0) {
                        NSMutableArray<NSString*> *resultArrayTTL = [NSMutableArray<NSString*> new];
                        
                        for (NSTextCheckingResult *textResult in regexArrayTTL) {
                            NSRange range = textResult.range;
                            NSString *substring = [ttl substringWithRange:range];
                            [resultArrayTTL addObject:substring];
                        }
                        
                        place = [self cleanseString:resultArrayTTL.firstObject clean:@","];
                        date = (resultArrayTTL.count > 1) ? resultArrayTTL.lastObject : nil;
                    }
                }
                
                ktpData.tempatLahir = place;
                ktpData.tanggalLahir = [self filterNumberOnly:date];

            }
            
            if ([lowerLineText containsString:@"jenis"] || [lowerLineText containsString:@"kelamin"]) {
                NSString *jenisKelamin = nil;
                NSError *error = nil;
                NSRegularExpression *regexJK = [NSRegularExpression regularExpressionWithPattern:@"LAKI-LAKI|PEREMPUAN|LAKI"
                                                                                       options:NSRegularExpressionCaseInsensitive error:&error];
                
                NSArray *regexArrayJK = [regexJK matchesInString:lineText options:0 range:NSMakeRange(0, lineText.length)];
                
                if (regexArrayJK.count > 0) {
                    NSMutableArray *resultArrayJJK = [NSMutableArray new];
                    for (NSTextCheckingResult *textResult in regexArrayJK) {
                        NSRange range = textResult.range;
                        NSString *substring = [lineText substringWithRange:range];
                        [resultArrayJJK addObject:substring];
                    }
                    
                    for (NSString *componentJJK in resultArrayJJK) {
                        NSInteger resultJJK = [regexJK numberOfMatchesInString:componentJJK options:0 range:NSMakeRange(0, componentJJK.length)];
                        if (resultJJK > 0) {
                            jenisKelamin = componentJJK;
                            break;
                        }
                    }
                } else {
                    jenisKelamin = [self findData:textBlocks line:line];
                    
                    NSArray *_regexArrayJK = [regexJK matchesInString:jenisKelamin options:0 range:NSMakeRange(0, jenisKelamin.length)];
                    
                    if (_regexArrayJK.count > 1) {
                        NSMutableArray *resultArrayJJK = [NSMutableArray new];
                        for (NSTextCheckingResult *textResult in _regexArrayJK) {
                            NSRange range = textResult.range;
                            NSString *substring = [jenisKelamin substringWithRange:range];
                            [resultArrayJJK addObject:substring];
                        }
                        
                        for (NSString *componentJJK in resultArrayJJK) {
                            NSInteger resultJJK = [regexJK numberOfMatchesInString:componentJJK options:0 range:NSMakeRange(0, componentJJK.length)];
                            if (resultJJK > 0) {
                                jenisKelamin = componentJJK;
                                break;
                            }
                        }
                    }
                }
                
                jenisKelamin = ([jenisKelamin containsString:@"PEREMPUAN"]) ? @"PEREMPUAN" : @"LAKI-LAKI";
                
                ktpData.jenisKelamin = jenisKelamin;
            }
            
            if ([lowerLineText containsString:@"gol"] || [lowerLineText containsString:@"darah"]) {
                ktpData.golDarah = (line.elements.count > 1) ? [self cleanseString:line.elements.lastObject.text clean:@":"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"alamat"]) {
                ktpData.alamat = (line.elements.count > 1) ? [self cleanseString:lineText clean:@"Alamat"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"rt"] || [lowerLineText containsString:@"rw"]) {
                NSString *RT = nil;
                NSString *RW = nil;
                NSError *error = nil;
                NSRegularExpression *regexRTRW = [NSRegularExpression regularExpressionWithPattern: @"\\d\\d\\d\\/\\d\\d\\d"
                                                                                           options:NSRegularExpressionCaseInsensitive
                                                                                             error:&error];
                
                NSArray *regexArrayRTRW = [regexRTRW matchesInString:lineText options:0 range:NSMakeRange(0, lineText.length)];
                
                if (regexArrayRTRW.count > 0) {
                    NSMutableArray<NSString*> *resultArrayRTRW = [NSMutableArray<NSString*> new];
                    for (NSTextCheckingResult *textResult in regexArrayRTRW) {
                        NSRange range = textResult.range;
                        NSString *substring = [lineText substringWithRange:range];
                        [resultArrayRTRW addObject:substring];
                    }
                    
                    if (resultArrayRTRW.count > 0) {
                        NSArray<NSString*> *splitRTRW = [resultArrayRTRW.lastObject componentsSeparatedByString:@"/"];
                        RT = splitRTRW.firstObject;
                        RW = splitRTRW.lastObject;
                    }
                    
                } else {
                    NSString *RTRW = [self findData:textBlocks line:line];
                    
                    regexArrayRTRW = [regexRTRW matchesInString:RTRW options:0 range:NSMakeRange(0, RTRW.length)];
                    
                    if (regexArrayRTRW.count > 0) {
                        NSArray<NSString*> *splitRTRW = [RTRW componentsSeparatedByString:@"/"];
                        RT = splitRTRW.firstObject;
                        RW = splitRTRW.lastObject;
                    }
                }
                
                
                ktpData.rt = [self filterNumberOnly:RT];
                ktpData.rw = [self filterNumberOnly:RW];
            }
            
            if ([lowerLineText containsString:@"kel"] || [lowerLineText containsString:@"desa"]) {
                if (line.elements.count > 1) {
                    NSString *cleanKel = [self cleanseString:lineText clean:@"Kel"];
                    NSString *cleanSlash = [self cleanseString:cleanKel clean:@"/"];
                    NSString *cleanKev = [self cleanseString:cleanSlash clean:@"Kev"];
                    ktpData.kelurahan = cleanKev;
                } else {
                    ktpData.kelurahan = [self findData:textBlocks line:line];
                }
            }
            
            if ([lowerLineText containsString:@"kecamatan"]) {
                ktpData.kecamatan = (line.elements.count > 1) ? [self cleanseString:lineText clean:@"Kecamatan"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"agama"]) {
                ktpData.agama = [self filterReligions:(line.elements.count > 1) ? [self cleanseString:lineText clean:@"Agama"] : [self findData:textBlocks line:line]];
            }
            
            if ([lowerLineText containsString:@"status perkawinan"]) {
                ktpData.statusPerkawinan = [self filterMarriageStatus:(line.elements.count > 1) ? [self cleanseString:lineText clean:@"Status Perkawinan"] : [self findData:textBlocks line:line]];
            }
            
            if ([lowerLineText containsString:@"pekerjaan"]) {
                ktpData.pekerjaan = (line.elements.count > 1) ? [self cleanseString:lineText clean:@"Pekerjaan"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"kewarganegaraan"]) {
                ktpData.kewarganegaraan = (line.elements.count > 1) ? [self cleanseString:lineText clean:@"Kewarganegaraan"] : [self findData:textBlocks line:line];
            }
            
            if ([lowerLineText containsString:@"berlaku hingga"]) {
                ktpData.berlakuHingga = (line.elements.count > 2) ? [self cleanseString:lineText clean:@"Berlaku Hingga"] : [self findData:textBlocks line:line];
            }
        }
    }
    return ktpData;
}

- (NSString *)findData:(NSArray*)textBlocks line:(MLKTextLine *)currentLine {
    NSString *result = @"";
    CGFloat topLeftCurrentLine = currentLine.frame.origin.x;
    CGFloat bottomLeftCurrentLine = topLeftCurrentLine + currentLine.frame.size.width;
    
    for (MLKTextBlock *textBlock in textBlocks) {
        for (MLKTextLine *line in textBlock.lines) {
            CGFloat centerYLine = line.frame.origin.x + (line.frame.size.width/2);
            
            if (centerYLine > topLeftCurrentLine && centerYLine < bottomLeftCurrentLine && currentLine.text != line.text) {
                result = line.text;
                break;
            }
        }
        if (![result isEqual: @""]) {
            break;
        }
    }
    
    return [result stringByReplacingOccurrencesOfString:@":" withString:@""];
}

- (NSString *)cleanseString:(NSString *)string clean:(NSString *)clean {
    return [[string stringByReplacingOccurrencesOfString:clean withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""];
}

- (BOOL)isContainsNumber:(NSString *)string {
    if ([string rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)filterNumberOnly:(NSString *)string {
    NSString *result = @"";
    NSMutableArray *arrayCharacter = [NSMutableArray new];
    for (int i = 0; i < string.length; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [arrayCharacter addObject:ichar];
    }
    NSError *error = nil;
    NSRegularExpression *regexCharacterNumberOnly = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$"
                                                                           options:NSRegularExpressionCaseInsensitive error:&error];
    for (NSString *character in arrayCharacter) {
        NSString *numberString = character;

        NSArray *regexResults = [regexCharacterNumberOnly matchesInString:numberString options:0 range:NSMakeRange(0, numberString.length)];
        if (regexResults.count == 0) {
            if ([numberString isEqual:@"L"] || [numberString isEqual:@"I"] || [numberString isEqual:@"l"] || [numberString isEqual:@"i"] || [numberString isEqual:@"J"] || [numberString isEqual:@"j"]) {
                numberString = @"1";
            } else if ([numberString isEqual:@"Z"] || [numberString isEqual:@"z"]) {
                numberString = @"2";
            } else if ([numberString isEqual:@"B"]) {
                numberString = @"3";
            } else if ([numberString isEqual:@"A"]) {
                numberString = @"4";
            } else if ([numberString isEqual:@"S"] || [numberString isEqual:@"s"]) {
                numberString = @"5";
            } else if ([numberString isEqual:@"b"] || [numberString isEqual:@"G"]) {
                numberString = @"6";
            } else if ([numberString isEqual:@"T"]) {
                numberString = @"7";
            } else if ([numberString isEqual:@"g"] || [numberString isEqual:@"q"]) {
                numberString = @"9";
            } else if ([numberString isEqual:@"o"] || [numberString isEqual:@"O"]) {
                numberString = @"0";
            } else {
                numberString = @"";
            }
        }
        result = [NSString stringWithFormat:@"%@%@", result, numberString];
    }
    
    return result;
}

- (NSString *)filterReligions:(NSString *)string {
    NSString *lowerLineText = [string lowercaseString];
    
    if ([self isContainsNumber:lowerLineText]) {
        return @"";
    }
    
    MOIReligionModel *religionModel = [self getCommonTextObject].religionModel;
    
    for (NSString *islamText in religionModel.islamArray) {
        if ([lowerLineText containsString:islamText]) {
            return @"ISLAM";
        }
    }
    
    for (NSString *kristenText in religionModel.kristenArray) {
        if ([lowerLineText containsString:kristenText]) {
            return @"KRISTEN";
        }
    }
    
    for (NSString *katolikText in religionModel.katholikArray) {
        if ([lowerLineText containsString:katolikText]) {
            return @"KATHOLIK";
        }
    }
    
    for (NSString *budhaText in religionModel.budhaArray) {
        if ([lowerLineText containsString:budhaText]) {
            return @"BUDHA";
        }
    }
    
    for (NSString *hinduText in religionModel.hinduArray) {
        if ([lowerLineText containsString:hinduText]) {
            return @"HINDU";
        }
    }
    
    for (NSString *konghuchuText in religionModel.konghuchuArray) {
        if ([lowerLineText containsString:konghuchuText]) {
            return @"KONGHUCHU";
        }
    }
    
    for (NSString *kepercayaanText in religionModel.kepercayaanArray) {
        if ([lowerLineText containsString:kepercayaanText]) {
            return @"KEPERCAYAAN";
        }
    }
    
    return string;
}

- (NSString *)filterMarriageStatus:(NSString *)string {
    NSString *lowerLineText = [string lowercaseString];
    
    if ([self isContainsNumber:lowerLineText]) {
        return @"";
    }
    
    MOIMarriageStatusModel *marriageStatusModel = [self getCommonTextObject].marriageStatusModel;
    
    for (NSString *kawinText in marriageStatusModel.kawinArray) {
        if ([lowerLineText containsString:kawinText]) {
            for (NSString *belumText in marriageStatusModel.belumArray) {
                if ([lowerLineText containsString:belumText]) {
                    return @"BELUM KAWIN";
                }
            }
            return @"KAWIN";
        }
    }
    
    for (NSString *ceraiText in marriageStatusModel.ceraiArray) {
        if ([lowerLineText containsString:ceraiText]) {
            for (NSString *hidupText in marriageStatusModel.hidupArray) {
                if ([lowerLineText containsString:hidupText]) {
                    return @"CERAI HIDUP";
                }
            }
            return @"CERAI MATI";
        }
    }

    return @"";
}

- (MOICommonTextModel *)getCommonTextObject {
    NSString *path = [[NSBundle bundleWithIdentifier:@"MNCIdentifier.OCR"] pathForResource:@"CommonText" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [[MOICommonTextModel alloc] initWithDictionary:dict];
}

@end
