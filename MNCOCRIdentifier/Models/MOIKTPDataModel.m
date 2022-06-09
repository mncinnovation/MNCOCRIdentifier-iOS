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
        return @{@"provinsi":self.provinsi,
                 @"kabKot":self.kabkota,
                 @"nik":self.NIK,
                 @"nama":self.nama,
                 @"tempatLahir":self.tempatLahir,
                 @"tglLahir":self.tanggalLahir,
                 @"jenisKelamin":self.jenisKelamin,
                 @"golDarah":self.golDarah,
                 @"alamat":self.alamat,
                 @"rt":self.rt,
                 @"rw":self.rw,
                 @"kelurahan":self.kelurahan,
                 @"kecamatan":self.kecamatan,
                 @"agama":self.agama,
                 @"statusPerkawinan":self.statusPerkawinan,
                 @"pekerjaan":self.pekerjaan,
                 @"kewarganegaraan":self.kewarganegaraan,
                 @"berlakuHingga":self.berlakuHingga};
    }
}

- (void)trimAllWhiteSpace {
    self.provinsi = [self.provinsi stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.kabkota = [self.kabkota stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.NIK = [self.NIK stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.nama = [self.nama stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.tempatLahir = [self.tempatLahir stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.tanggalLahir = [self.tanggalLahir stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.jenisKelamin = [self.jenisKelamin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.golDarah = [self.golDarah stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.alamat = [self.alamat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.rt = [self.rt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.rw = [self.rw stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.kelurahan = [self.kelurahan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.kecamatan = [self.kecamatan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.agama = [self.agama stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.statusPerkawinan = [self.statusPerkawinan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.pekerjaan = [self.pekerjaan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.kewarganegaraan = [self.kewarganegaraan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.berlakuHingga = [self.berlakuHingga stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
