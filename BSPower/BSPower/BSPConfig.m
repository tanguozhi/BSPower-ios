//
//  BSPConfig.m
//  BSPower
//
//  Created by tanguozhi on 2018-04-01.

#import "BSPConfig.h"

@interface BSPConfig()

@property(nonatomic, copy)NSString *mServerUrl;
@property(nonatomic, assign)BOOL mHTTPSValidatesSecureCertificate;

@end

@implementation BSPConfig

static BSPConfig *_sharedBSPConfig = nil;

+(BSPConfig *)sharedBSPConfig{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedBSPConfig = [[BSPConfig alloc] init];
    });
    return _sharedBSPConfig;
}

- (NSString *)getServerUrl {
    if (!_mServerUrl) {
        NSString *serverUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SERVER_URL];
        if (serverUrl && ![@"" isEqualToString:serverUrl]) {
            _mServerUrl = serverUrl;
        }
    }
    return _mServerUrl;
}

- (void)setServerUrl:(NSString *)serverUrl {
    _mServerUrl = serverUrl;
}

- (BOOL)getHTTPSValidatesSecureCertificate {
    return _mHTTPSValidatesSecureCertificate;
}

- (void)setHTTPSValidatesSecureCertificate:(BOOL)isValidatesSecureCertificate {
    _mHTTPSValidatesSecureCertificate = isValidatesSecureCertificate;
}

@end
