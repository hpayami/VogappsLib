//
//  UIUtilities.h
//  VogappsLib
//
//  Created by Volkan Demircin on 7/29/13.
//  Copyright (c) 2013 Vogapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define isIPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isIPad   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define ViewOrientationIsPortrait(view) (view.bounds.size.width < view.bounds.size.height ? YES : NO)
#define ViewOrientationIsLandscape(view) (view.bounds.size.width >= view.bounds.size.height ? YES : NO)

/*! UIUtilities class contains view related static methods that are frequently used throughout the application.
 *\
 */
@interface UIUtilities : NSObject

#pragma  mark - C Type
/*! Creates and returns localized UIImage from the language bundle
 \param imageName NSString value of the image name.
 */
UIImage *LocalizedImage(NSString *imageName);

/*! Returns the full path of the localized image
 \param imageName NSString value of the image name.
 */
NSString *LocalizedImagePath(NSString *imageName);


/*! Returns the full path of the localized file
 \param fileName NSString value of the file name.
 */
NSString *LocalizedFile(NSString* fileName);

/*! Returns the appropriate xib name for the device
 \param baseName Base name of the xib file
 */
+ (NSString *)xibForDevice:(NSString *)baseName __deprecated;

/*! Returns the top most presented view controller
 */
+ (UIViewController *) topMostPresentedViewController;

/**
 *  Finds and returns max zPosition of all subviews view(including childViewControllers)
 *  @return max zPosition
 */
+ (CGFloat)topMostZPositionInViewController:(UIViewController *)viewController;

/**
 *  Take the snapshot of a desired view
 *
 *  @param view view to take the snapshot. All of the views in the hieararchy will be included.
 *
 *  @return Snapshot for the desired view
 */
+ (UIImage *) snapshotForView:(UIView *)view;

@end


@interface UIImage(Scaling)

- (UIImage *)imageWithScale:(CGFloat)scale;
- (UIImage *)scaleToSizeKeepAspect:(CGSize)size;
- (UIImage *)fixOrientation;

@end