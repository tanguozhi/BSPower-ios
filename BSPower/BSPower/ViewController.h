//
//  ViewController.h
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

- (void)replace:(NSString *)pageName transition:(NSString *)type;

@end;

@interface ViewController : UIViewController


@end

