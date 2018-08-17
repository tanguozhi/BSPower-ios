//
//  WebviewView.h
//  BSPower
//
//  Created by guozhi tan on 2018/8/16.
//  Copyright © 2018 sinosoft. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JSExport.h>

@protocol AppJSObjectDelegate <JSExport>

-(void)jsLogout;

@end

@interface AppJSObject : NSObject<AppJSObjectDelegate>

@property(nonatomic, weak) id<AppJSObjectDelegate> delegate;

@end

@interface WebviewView : UIView

- (void)initView:(id<ViewControllerDelegate>)delegate;

@end

