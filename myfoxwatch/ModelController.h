//
//  ModelController.h
//  KaziMyFox
//
//  Created by Madjid KAZI-TANI on 20/07/2015.
//  Copyright (c) 2015 Madjid KAZI-TANI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

