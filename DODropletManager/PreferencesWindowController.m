***REMOVED***
***REMOVED***  PreferencesWindowController.m
***REMOVED***  DODropletManager
***REMOVED***
***REMOVED***  Created by David Hsieh on 4/27/14.
***REMOVED***  Copyright (c) 2014 David Hsieh. All rights reserved.
***REMOVED***

#import "PreferencesWindowController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController


- (id)init {
    self=[super initWithWindowNibName:@"PreferencesWindow"];
    if(self)
    {
        

    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        ***REMOVED*** Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    

    ***REMOVED***perform any initializations
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    if ([userDefaults objectForKey:@"clientID"]) {
        [_ClientIDTF setStringValue:[userDefaults objectForKey:@"clientID"]];
    }
    
    if ([userDefaults objectForKey:@"APIKey"]) {
        [_APIKeyTF setStringValue:[userDefaults objectForKey:@"APIKey"]];
    }
    
    NSLog(@"ClientID %@", [userDefaults objectForKey:@"clientID"]);
}


- (IBAction)savePreferences:(id)sender {
    
    
    [userDefaults setObject:_ClientIDTF.stringValue forKey:@"clientID"];
    [userDefaults setObject:_APIKeyTF.stringValue forKey:@"APIKey"];
    
    [userDefaults synchronize];
    
    NSLog(@"saved %@", _ClientIDTF.stringValue);
    
}


@end
