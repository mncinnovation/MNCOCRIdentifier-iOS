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

- (CGFloat)insertData:(MOIKTPDataModel *)data {
    CGFloat count = 0;
    
    if (self.provinsi == nil) {
        if (data.provinsi != nil && ![data.provinsi isEqual: @""]) {
            self.provinsi = data.provinsi;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kabkota == nil) {
        if (data.kabkota != nil && ![data.kabkota  isEqual: @""]) {
            self.kabkota = data.kabkota;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.NIK == nil) {
        if (data.NIK != nil && ![data.NIK  isEqual: @""]) {
            self.NIK = data.NIK;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.nama == nil) {
        if (data.nama != nil && ![data.nama  isEqual: @""]) {
            self.nama = data.nama;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.tempatLahir == nil) {
        if (data.tempatLahir != nil && ![data.tempatLahir  isEqual: @""]) {
            self.tempatLahir = data.tempatLahir;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.tanggalLahir == nil) {
        if (data.tanggalLahir != nil && ![data.tanggalLahir  isEqual: @""]) {
            self.tanggalLahir = data.tanggalLahir;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.jenisKelamin == nil) {
        if (data.jenisKelamin != nil && ![data.jenisKelamin  isEqual: @""]) {
            self.jenisKelamin = data.jenisKelamin;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.golDarah == nil) {
        if (data.golDarah != nil && ![data.golDarah  isEqual: @""]) {
            self.golDarah = data.golDarah;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.alamat == nil) {
        if (data.alamat != nil && ![data.alamat  isEqual: @""]) {
            self.alamat = data.alamat;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.rt == nil) {
        if (data.rt != nil && ![data.rt  isEqual: @""]) {
            self.rt = data.rt;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.rw == nil) {
        if (data.rw != nil && ![data.rw  isEqual: @""]) {
            self.rw = data.rw;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kelurahan == nil) {
        if (data.kelurahan != nil && ![data.kelurahan  isEqual: @""]) {
            self.kelurahan = data.kelurahan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kecamatan == nil) {
        if (data.kecamatan != nil && ![data.kecamatan  isEqual: @""]) {
            self.kecamatan = data.kecamatan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.agama == nil) {
        if (data.agama != nil && ![data.agama  isEqual: @""]) {
            self.agama = data.agama;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.statusPerkawinan == nil) {
        if (data.statusPerkawinan != nil && ![data.statusPerkawinan  isEqual: @""]) {
            self.statusPerkawinan = data.statusPerkawinan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.pekerjaan == nil) {
        if (data.pekerjaan != nil && ![data.pekerjaan  isEqual: @""]) {
            self.pekerjaan = data.pekerjaan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kewarganegaraan == nil) {
        if (data.kewarganegaraan != nil && ![data.kewarganegaraan  isEqual: @""]) {
            self.kewarganegaraan = data.kewarganegaraan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.berlakuHingga == nil) {
        if (data.berlakuHingga != nil && ![data.berlakuHingga  isEqual: @""]) {
            self.berlakuHingga = data.berlakuHingga;
            count++;
        }
    } else {
        count++;
    }
    
    return (count/18) * 100;
}

- (void)replaceDataNil {
    if (self.provinsi == nil) {
        self.provinsi = @"";
    }
    
    if (self.kabkota == nil) {
        self.provinsi = @"";
    }
    
    if (self.NIK == nil) {
        self.NIK = @"";
    }
    
    if (self.nama == nil) {
        self.nama = @"";
    }
    
    if (self.tempatLahir == nil) {
        self.tempatLahir = @"";
    }
    
    if (self.tanggalLahir == nil) {
        self.tanggalLahir = @"";
    }
    
    if (self.golDarah == nil) {
        self.golDarah = @"";
    }
    
    if (self.alamat == nil) {
        self.alamat = @"";
    }
    
    if (self.rt == nil) {
        self.rt = @"";
    }
    
    if (self.rw == nil) {
        self.rw = @"";
    }
    
    if (self.kelurahan == nil) {
        self.kelurahan = @"";
    }
    
    if (self.kecamatan == nil) {
        self.kecamatan = @"";
    }
    
    if (self.jenisKelamin == nil) {
        self.jenisKelamin = @"";
    }
    
    if (self.agama == nil) {
        self.agama = @"";
    }
    
    if (self.statusPerkawinan == nil) {
        self.statusPerkawinan = @"";
    }
    
    if (self.pekerjaan == nil) {
        self.pekerjaan = @"";
    }
    
    if (self.kewarganegaraan == nil) {
        self.kewarganegaraan = @"";
    }
    
    if (self.berlakuHingga == nil) {
        self.berlakuHingga = @"";
    }
}

@end
