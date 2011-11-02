//
//  AppDelegate.h
//  EjemploCocos2D
//
//  Created by Juan Manuel Marchese on 02-11-11.
//  Copyright JMM 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
