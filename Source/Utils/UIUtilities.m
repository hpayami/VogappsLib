//
//  UIUtilities.m
//  VogappsLib
//
//  Created by Volkan Demircin on 7/29/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import "UIUtilities.h"

@implementation UIUtilities

+ (NSString *)xibForDevice:(NSString *)baseName
{
    NSString *xibName;
    if (isIPhone) {
        xibName = baseName;
    }
    else{
        xibName = [NSString stringWithFormat:@"%@HD", baseName];
    }
    
    return xibName;
}

+ (UIViewController *) topMostPresentedViewController {
    //find the topmost presented viewcontroller
    UIViewController* topMostPresentedViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while(topMostPresentedViewController.presentedViewController) {
        topMostPresentedViewController = topMostPresentedViewController.presentedViewController;
    }
    
    return topMostPresentedViewController;
}

+ (CGFloat)topMostZPositionInViewController:(UIViewController *)viewController{
    __block CGFloat maxZIndex = 0;
    [viewController.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *childViewController, NSUInteger idx, BOOL *stop) {
        maxZIndex = MAX(maxZIndex, childViewController.view.layer.zPosition);
        [childViewController.view.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
            maxZIndex = MAX(maxZIndex, subview.layer.zPosition);
        }];
    }];
    
    return maxZIndex;
}

+ (UIImage *) snapshotForView:(UIView *)view {
    UIImage *image = nil;
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return image;
}

@end

#pragma mark - C Type

UIImage *LocalizedImage(NSString *imageName)
{
    NSString *fileLocation = LocalizedImagePath(imageName);
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:fileLocation])
    {
        if ([fileLocation rangeOfString:@".png"].location == NSNotFound || [fileLocation rangeOfString:@".jpg"].location == NSNotFound) {
            NSString *newfileLocation = [NSString stringWithFormat:@"%@.png", fileLocation];
            if (![fileMgr fileExistsAtPath:newfileLocation]) {
                // try jpg
                newfileLocation = [NSString stringWithFormat:@"%@.jpg", fileLocation];
                if (![fileMgr fileExistsAtPath:newfileLocation]) {
                    return [UIImage imageNamed:imageName];
                }
            }
            fileLocation = newfileLocation;
        }
    }
    
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:fileLocation];
    return img;
}

NSString *LocalizedImagePath(NSString *imageName)
{
    NSString *langCode = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *path= [[NSBundle mainBundle] pathForResource:langCode ofType:@"lproj"];
    NSString *fileLocation = [NSString stringWithFormat:@"%@/%@", path, imageName];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:fileLocation]) {
        return fileLocation;
    }
    else if ([imageName rangeOfString:@"."].location != NSNotFound){
        NSArray *fileSplit = [imageName componentsSeparatedByString:@"."];
        fileLocation = [NSString stringWithFormat:@"%@/%@@2x.%@",path, [fileSplit objectAtIndex:0], [fileSplit objectAtIndex:1]];
        if ([fileMgr fileExistsAtPath:fileLocation]) {
            return fileLocation;
        }
    }
    
    NSString *deviceExtension = isIPad ? @"~ipad" : @"~iphone";
    if([imageName rangeOfString:@"~"].location == NSNotFound){
        if([imageName rangeOfString:@"."].location != NSNotFound){
            NSArray *fileSplit = [imageName componentsSeparatedByString:@"."];
            imageName = [NSString stringWithFormat:@"%@%@.%@", [fileSplit objectAtIndex:0], deviceExtension, [fileSplit objectAtIndex:1]];
        }
        else{
            imageName = [NSString stringWithFormat:@"%@%@", imageName, deviceExtension];
        }
    }
    
    
    fileLocation = [NSString stringWithFormat:@"%@/%@", path, imageName];
    
    if (![fileMgr fileExistsAtPath:fileLocation])
    {
        NSArray *fileSplit = [imageName componentsSeparatedByString:@"~"];
        fileLocation = [NSString stringWithFormat:@"%@/%@@2x~%@",path, [fileSplit objectAtIndex:0], [fileSplit objectAtIndex:1]];
    }
    
    return fileLocation;
}

NSString *LocalizedFile(NSString* fileName)
{
    NSString *langCode = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *path= [[NSBundle mainBundle] pathForResource:langCode ofType:@"lproj"];
    NSString *fileLocation = [NSString stringWithFormat:@"%@/%@", path, fileName];
    return fileLocation;
}



@implementation UIImage (Scaling)

- (UIImage *)imageWithScale:(CGFloat)scale
{
    CGSize newSize = CGSizeMake(self.size.width * self.scale * scale, self.size.height * self.scale * scale);
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)scaleToSizeKeepAspect:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    CGFloat ws = size.width/self.size.width;
    CGFloat hs = size.height/self.size.height;
    
    if (ws < hs) {
        ws = hs/ws;
        hs = 1.0;
    } else {
        hs = ws/hs;
        ws = 1.0;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(size.width/2-(size.width*ws)/2,
                                           size.height/2-(size.height*hs)/2, size.width*ws,
                                           size.height*hs), self.CGImage);
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
