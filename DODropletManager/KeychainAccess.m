//
//  KeychainAccess.m
//  DODropletManager
//
//  Created by Daniel Parnell on 29/04/2014.
//  Copyright (c) 2014 David Hsieh. All rights reserved.
//

#import "KeychainAccess.h"
#import <Security/SecKeychain.h>

static const char *digital_ocean = "Digital Ocean";
static const char *account = "Account";

static NSString *serviceName = @"digital_ocean";

@implementation KeychainAccess





+ (BOOL) storeToken:(NSString*)token error:(NSError**)error {
    
    // Set password
    SecKeychainRef keychain = NULL; // User's default keychain
    
    
    // Delete keychain item if already exists
    [self removeToken:token error:nil];
    
    const char *passwordData = [[NSString stringWithFormat: @"%@", token] UTF8String];
    OSStatus status = SecKeychainAddGenericPassword(keychain,
                                                    (UInt32)strlen(digital_ocean), digital_ocean,
                                                    (UInt32)strlen(account), account,
                                                    (UInt32)strlen(passwordData), passwordData,
                                                    NULL);
    
    
    
    
    if (status == noErr) {
        return YES;
    }
    
    if(error) {
        *error = [NSError errorWithDomain: NSLocalizedString(@"Keychain", @"Keychain") code: status userInfo: nil];
    }
    
    return NO;

    
}

+ (BOOL) getToken:(NSString**)token error:(NSError**)error {
    
    
    SecKeychainRef keychain = NULL; // User's default keychain
    // Get password
    char *password = NULL;
    UInt32 passwordLen = 0;
    
    OSStatus status = SecKeychainFindGenericPassword(keychain,
                                                     (UInt32)strlen(digital_ocean), digital_ocean,
                                                     (UInt32)strlen(account), account,
                                                     &passwordLen, (void**)&password,
                                                     NULL);
    
    if (status == noErr) {
        // Cool! Use pwd
        NSString *tmp = [NSString stringWithUTF8String: password];
        *token = tmp;
        SecKeychainItemFreeContent(NULL, (void*)password);
        
        return YES;
    }
    
    if(error) {
        *error = [NSError errorWithDomain: NSLocalizedString(@"Keychain", @"Keychain") code: status userInfo: nil];
    }
    
    return NO;
}

+ (BOOL) removeToken:(NSString*)token error:(NSError**)error {
    
    
    SecKeychainRef keychain = NULL; // User's default keychain
    SecKeychainItemRef keychainItem;
    
    OSStatus status = SecKeychainFindGenericPassword(keychain,
                                                     (UInt32)strlen(digital_ocean), digital_ocean,
                                                     (UInt32)strlen(account), account,
                                                     NULL, NULL,
                                                     &keychainItem);
    
    
    if (status == noErr) {
        SecKeychainItemDelete(keychainItem);
        CFRelease(keychainItem);
    } else {
        if (error) {
            *error = [NSError errorWithDomain: NSLocalizedString(@"Keychain", @"Keychain") code: status userInfo: nil];
        }
    }
    
    
    
    return NO;
}

@end
