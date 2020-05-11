#import "base64Compression.h"
#import "Base64.h"
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>


@implementation base64Compression
	
- (void)getComprBase64:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* base64string = [command.arguments objectAtIndex:0];
    NSString* compresssedstring = [[self class]  decodeString:base64string];
	
    if (compresssedstring != nil && [compresssedstring length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:compresssedstring];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	
}

+(NSString*) decodeString:(NSString*) string {

    //Initialise base64 class
    //[Base64 initialize];
    NSData* resultData=[Base64 decode:string];
    
    //generate image from NSData
    UIImage *image=[UIImage imageWithData: resultData];
    
	//resize the image & re-transfer to NSData
    //base64Compression * instance1=[ [base64Compression alloc]init];
    UIImage* resized = [[self class] resizeImage:image width:768  height:1024]; 
	
	//set your dimensions as per request.
    NSData* pictureData = UIImageJPEGRepresentation(resized, 0.25f); // set compression ratio as per your request.

    //this is final endoced base64 string which have appropriate compressed image

    NSString* resultDataString=[[self class] base64forData:pictureData];
    return resultDataString;
	
}
    
+(UIImage *)resizeImage:(UIImage *)anImage width:(int)width height:(int)height
    {
        
        CGImageRef imageRef = [anImage CGImage];
        
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
        
        if (alphaInfo == kCGImageAlphaNone)
            alphaInfo = kCGImageAlphaNoneSkipLast;
        
        
        CGContextRef bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), 4 * width, CGImageGetColorSpace(imageRef), alphaInfo);
        
        CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
        
        CGImageRef ref = CGBitmapContextCreateImage(bitmap);
        UIImage *result = [UIImage imageWithCGImage:ref];
        
        CGContextRelease(bitmap);
        CGImageRelease(ref);
        
        return result;      
    }


+(NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
@end
