//
//  Message+CoreDataProperties.h
//  CoreDataChat
//
//  Created by wangguigui on 16/6/29.
//  Copyright © 2016年 topsci. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
