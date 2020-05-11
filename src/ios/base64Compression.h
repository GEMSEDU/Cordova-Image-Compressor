#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>

@interface base64Compression : CDVPlugin
  
- (void)getComprBase64:(CDVInvokedUrlCommand*)command;

+ (NSString*) decodeString:(NSString*) string;
+(UIImage *)resizeImage:(UIImage *)anImage width:(int)width height:(int)height;
+ (NSString*)base64forData:(NSData*)theData ;

@end
