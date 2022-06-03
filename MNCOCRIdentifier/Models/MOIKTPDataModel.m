//
//  MOIKTPDataModel.m
//  MNCOCRIdentifier
//
//  Created by MCOMM00008 on 30/05/22.
//

#import "MOIKTPDataModel.h"

@implementation MOIKTPDataModel

- (NSDictionary *)dictionary {
    if (self == nil) {
        return nil;
    } else {
        return @{@"propinsi":self.provinsi, @"kabKot":self.kabkota, @"nik":self.NIK, @"nama":self.nama, @"tempatLahir":self.tempatLahir, @"tglLahir":self.tanggalLahir, @"jenisKelamin":self.jenisKelamin, @"golDarah":self.golDarah, @"alamat":self.alamat, @"rt":self.rt, @"rw":self.rw, @"kelurahan":self.kelurahan, @"kewarganegaraan":self.kewarganegaraan, @"berlakuHingga":self.berlakuHingga};
    }
}

@end
