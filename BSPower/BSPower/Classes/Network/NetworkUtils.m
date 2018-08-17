/**
 * NetworkUtils.m
 * XRKit
 * Created by tanguozhi on 2018-04-01.
 */

#import "NetworkUtils.h"
#import "BSPConfig.h"
#import "AFURLResponseSerialization.h"
#import "AFHTTPSessionManager.h"

@interface NetworkUtils()

@property(nonatomic, retain)NSMutableDictionary *mDelegateDic;

@end;

@implementation NetworkUtils

static NetworkUtils *_sharedNetworkUtils = nil;

+(NetworkUtils *)sharedNetworkUtils{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedNetworkUtils = [[NetworkUtils alloc] init];
        
        _sharedNetworkUtils.mDelegateDic = [NSMutableDictionary dictionary];
    });
    return _sharedNetworkUtils;
}

- (void)startAsyn:(NSString *)url header:(NSDictionary *)header body:(NSData *)body method:(NSString *)method delegate:(id<NetworkUtilsDelegate>)delegate{
    [self start:url header:header body:body method:method isSyn:false delgate:delegate];
    
}

- (id<NetworkUtilsDelegate>)getDelegate:(NSString *)key {
    if (_mDelegateDic && key) {
        return [_mDelegateDic objectForKey:key];
    }
    return nil;
}

- (void)start:(NSString *)url header:(NSDictionary *)header body:(NSData *)body method:(NSString *)method isSyn:(BOOL)isSyn delgate:(id<NetworkUtilsDelegate>)delegate {
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    
    if (url) {
        if ([url rangeOfString:@"http://"].length<=0 && [url rangeOfString:@"https://"].length<=0) {
            if ([url hasPrefix:@"/"]) {
                url = [NSString stringWithFormat:@"%@%@", [[BSPConfig sharedBSPConfig] getServerUrl], url];
            } else {
                url = [NSString stringWithFormat:@"%@/%@", [[BSPConfig sharedBSPConfig] getServerUrl], url];
            }
            
        }
    }
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    
    [request setTimeoutInterval:30];

    [request setHTTPBody:[NSMutableData dataWithData:body]];

    if (![[BSPConfig sharedBSPConfig] getHTTPSValidatesSecureCertificate]) {  //跳过HTTPS证书校验
        httpSessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        httpSessionManager.securityPolicy.allowInvalidCertificates = YES;
        [httpSessionManager.securityPolicy setValidatesDomainName:NO];
    }
    
    if (header && [header count] > 0) {
        NSArray *allKeys = [header allKeys];
        for (NSString *key in allKeys) {
            NSString *value = [header objectForKey:key];
            [request addValue:value forHTTPHeaderField:key];
        }
    }
    httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

    if (isSyn) {   //同步请求
        httpSessionManager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        [[httpSessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress *uploadProgress){ //上传进度
            if (delegate && [delegate respondsToSelector:@selector(connectionUploadProgress:connection:)]) {
                [delegate connectionUploadProgress:uploadProgress connection:self];
            }
        }  downloadProgress:^(NSProgress *downloadProgress){    //下载进度
            if (delegate && [delegate respondsToSelector:@selector(connectionDownloadProgress:connection:)]) {
                [delegate connectionDownloadProgress:downloadProgress connection:self];
            }
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//            self.mResponseError = error;
//            [self handleResult:response responseData:responseObject];
            
            dispatch_semaphore_signal(semaphore);
        }] resume];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
//        NSString *nameStr =  [[NSString alloc]initWithData:self.mResponseData encoding:NSUTF8StringEncoding];
    } else {    //异步请求
        [[httpSessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress *uploadProgress){ //上传进度
            if (delegate && [delegate respondsToSelector:@selector(connectionUploadProgress:connection:)]) {
                [delegate connectionUploadProgress:uploadProgress connection:self];
            }
        }  downloadProgress:^(NSProgress *downloadProgress){    //下载进度
            if (delegate && [delegate respondsToSelector:@selector(connectionDownloadProgress:connection:)]) {
                [delegate connectionDownloadProgress:downloadProgress connection:self];
            }
        } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) { //完成
            NSMutableDictionary *resultDic = [self handleResult:response responseData:responseObject];
            if (!error) {
                if (delegate && [delegate respondsToSelector:@selector(connectionDidFinish:)]) {
                    [delegate connectionDidFinish:resultDic];
                }
            } else {
                if (delegate && [delegate respondsToSelector:@selector(connectionDidFaile:)]) {
                    [delegate connectionDidFaile:resultDic];
                }
            }
        }] resume];
    }
}

- (NSMutableDictionary *)handleResult:(NSURLResponse *)response responseData:(NSData *)responseData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    
    if (responseData) {
        [dic setObject:responseData forKey:NETWORK_RESPONSE_DATA];
    }
    
    [dic setObject:[NSString stringWithFormat:@"%d", (int)[httpResponse statusCode]] forKey:NETWORK_RESPONSE_CODE];
    
    if ([httpResponse allHeaderFields]) {
        [dic setObject:[httpResponse allHeaderFields]  forKey:NETWORK_RESPONSE_HEADER];
    }
    return dic;
}

@end
