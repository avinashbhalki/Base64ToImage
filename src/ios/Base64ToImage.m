//
//  Base64ToImage.m
//  CloseOut
//
//  Created by Avi on 12/09/14.
//
//

#import "Base64ToImage.h"

@implementation Base64ToImage

- (void)base64ToImage:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    NSString* imageName = [command.arguments objectAtIndex:1];
    
    if (echo != nil && [echo length] > 0)
    {
        
        NSData *imageData = [NSData dataFromBase64String:echo];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"CapturedPhotos"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSError* error = nil;
        if (![fileManager fileExistsAtPath:dataPath])
		[fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
        else {
        }
        
        
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"CapturedPhotos/%@.jpg", imageName]];
        
        NSString *imagePath1 = [NSString stringWithFormat:@"/%@.jpg", imageName];
		
		if (imageData!=NULL)
		{
			[imageData writeToFile:imagePath atomically:YES];
            
		} else {
		}
        
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
        
        if (fileExists) {
        }
        else
        {
             NSLog(@"File doesn't Exists");
        }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imagePath1];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
