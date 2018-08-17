/**
 * NetworkUtils.h
 * XRKit
 * Created by tanguozhi on 2018-04-01.
 */

#import <Foundation/Foundation.h>

#define NETWORK_RESPONSE_DATA @"responseData"
#define NETWORK_RESPONSE_CODE @"responseCode"
#define NETWORK_RESPONSE_HEADER @"responseHeader"

@protocol XRNetworkConnectionDelegate;

@interface NetworkUtils : NSObject

+(NetworkUtils *)sharedNetworkUtils;

/**初始化方法
  */
- (void)startAsyn:(NSString *)url header:(NSDictionary *)header body:(NSData *)body method:(NSString *)method delegate:(id)delegate;

@end

@protocol NetworkUtilsDelegate <NSObject>

@optional
/**connection上传进度
 */
- (void)connectionUploadProgress:(NSProgress *)uploadProgress connection:(NetworkUtils *)connection;

/**connection下载进度
 */
- (void)connectionDownloadProgress:(NSProgress *)downloadProgress connection:(NetworkUtils *)connection;

/**connection请求成功后回调并返回请求结果.
 */
- (void)connectionDidFinish:(NSMutableDictionary *)resultDic;

/**connection请求失败后回调并返回失败结果.
 */
- (void)connectionDidFaile:(NSMutableDictionary *)resultDic;;
@end;
