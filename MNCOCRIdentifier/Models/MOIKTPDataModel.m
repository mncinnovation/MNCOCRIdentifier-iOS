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
        if (data.provinsi != nil) {
            self.provinsi = data.provinsi;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kabkota == nil) {
        if (data.kabkota != nil) {
            self.kabkota = data.kabkota;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.NIK == nil) {
        if (data.NIK != nil) {
            self.NIK = data.NIK;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.nama == nil) {
        if (data.nama != nil) {
            self.nama = data.nama;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.tempatLahir == nil) {
        if (data.tempatLahir != nil) {
            self.tempatLahir = data.tempatLahir;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.tanggalLahir == nil) {
        if (data.tanggalLahir != nil) {
            self.tanggalLahir = data.tanggalLahir;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.jenisKelamin == nil) {
        if (data.jenisKelamin != nil) {
            self.jenisKelamin = data.jenisKelamin;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.golDarah == nil) {
        if (data.golDarah != nil) {
            self.golDarah = data.golDarah;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.alamat == nil) {
        if (data.alamat != nil) {
            self.alamat = data.alamat;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.rt == nil) {
        if (data.rt != nil) {
            self.rt = data.rt;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.rw == nil) {
        if (data.rw != nil) {
            self.rw = data.rw;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kelurahan == nil) {
        if (data.kelurahan != nil) {
            self.kelurahan = data.kelurahan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kecamatan == nil) {
        if (data.kecamatan != nil) {
            self.kecamatan = data.kecamatan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.agama == nil) {
        if (data.agama != nil) {
            self.agama = data.agama;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.statusPerkawinan == nil) {
        if (data.statusPerkawinan != nil) {
            self.statusPerkawinan = data.statusPerkawinan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.statusPerkawinan == nil) {
        if (data.statusPerkawinan != nil) {
            self.statusPerkawinan = data.statusPerkawinan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.kewarganegaraan == nil) {
        if (data.kewarganegaraan != nil) {
            self.kewarganegaraan = data.kewarganegaraan;
            count++;
        }
    } else {
        count++;
    }
    
    if (self.berlakuHingga == nil) {
        if (data.berlakuHingga != nil) {
            self.berlakuHingga = data.berlakuHingga;
            count++;
        }
    } else {
        count++;
    }
    
    return (count/18) * 100;
}

@end
