//
//  MyClass.h
//  
//
//  Created by 안창범 on 2021/02/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Python : NSObject

- (instancetype)initWithArgc:(int)argc argv:(const char *_Nullable)argv;

@end

NS_ASSUME_NONNULL_END
