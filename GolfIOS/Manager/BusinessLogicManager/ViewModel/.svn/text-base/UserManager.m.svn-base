//
//  UserManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserManager.h"
#import "UserProcessor.h"

@interface UserManager ()

@property (nonatomic, strong) UserProcessor *processor;


@end

@implementation UserManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[UserProcessor alloc] init];
    }
    return self;
}

- (void)postMyFriendListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendListWithParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               NSArray *data = responObject[@"data"];
                                               
                                               NSMutableArray *dict = [[NSMutableArray alloc] init];
                                               for (NSDictionary *item in data) {
                                                   FriendUserModel *model = [FriendUserModel mj_objectWithKeyValues:item];
                                                   [dict addObject:model];
                                               }
                                               responSuccess(dict);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                           }
                                       }
                                       failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                       }];
}

- (void)postMyFriendAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendAddWithParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               responSuccess(responObject[@"showMessage"]);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                           }
                                       }
                                       failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                       }];

}

- (void)postCreateFriendAddWithParameters:(NSDictionary *)parameters friendArys:(NSString *)friendsId success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postCreateFriendAddWithParameters:parameters
                                          success:^(id responObject) {
                                              if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                  if (friendsId.length) {
                                                      NSNumber *groupId = responObject[@"data"][@"id"];
                                                      //添加好友进入分组
            [weakself.processor postAddFriendToGroupWithParameters:@{@"friendIds":friendsId, @"groupId":groupId} success:^(id responObject) {
                                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                              responSuccess(responObject[@"showMessage"]);
                                                          }else{
                                                              responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                          }
                                                      } failure:^(NSError *error) {
                                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                      }];
                                                  }else{
                                                      //未传入添加好友。仅创建空好友分组
                                                      responSuccess(responObject[@"showMessage"]);
                                                  }
                                              }else{
                                                  responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                              }

                                          }
                                          failure:^(NSError *error) {
                                              responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                          }];
}

- (void)postDeleteMyFriendWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postDeleteMyFriendWithParameters:parameters
                                         success:^(id responObject) {
                                             if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                 responSuccess(responObject[@"showMessage"]);
                                             }else{
                                                 responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                             }
                                         } failure:^(NSError *error) {
                                             responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                         }];
}

- (void)postMyFriendGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendGroupWithParameters:parameters
                                         success:^(id responObject) {
                                             if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                 NSMutableArray *data = [[NSMutableArray alloc] init];
                                                 for (NSDictionary *dict in responObject[@"data"]) {
                                                     FriendGroupItemModel *model = [FriendGroupItemModel mj_objectWithKeyValues:dict];
                                                     [data addObject:model];
                                                 }
                                                 responSuccess(data);
                                             }else{
                                                 responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                             }
                                         } failure:^(NSError *error) {
                                             responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                         }];

}

- (void)postMyFriendDeleteGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendDeleteGroupWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      responSuccess(responObject[@"showMessage"]);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                  }
                                              }
                                              failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                              }];
}

- (void)postAddFriendToGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAddFriendToGroupWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   responSuccess(responObject[@"showMessage"]);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                               }

                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                           }];
}

- (void)postMyFriendInviteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendInviteListWithParameters:parameters
                                             success:^(id responObject) {
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     NSArray *data = responObject[@"data"];
                                                     NSMutableArray *newData = [NSMutableArray array];
                                                     for (NSDictionary *dict in data) {
                                                         FriendUserModel *model = [FriendUserModel mj_objectWithKeyValues:dict];
                                                         [newData addObject:model];
                                                     }
                                                     responSuccess(newData);
                                                 }else{
                                                     responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                 }

                                             }
                                             failure:^(NSError *error) {
                                                 responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                             }];
}


- (void)postMyFriendAllowAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendAllowAddWithParameters:parameters
                                             success:^(id responObject) {
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     responSuccess(responObject[@"showMessage"]);
                                                 }else{
                                                     responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                 }
                                             }
                                             failure:^(NSError *error) {
                                                 responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                             }];
}


- (void)postMyFriendEditGroupNameWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendEditGroupNameWithParameters:parameters
                                                success:^(id responObject) {
                                                    if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                        responSuccess(responObject[@"showMessage"]);
                                                    }else{
                                                        responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                    }
                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                }];
}

- (void)postMyFriendEditGroupInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendEditGroupInfoWithParameters:parameters
                                                success:^(id responObject) {
                                                    if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                        responSuccess(responObject[@"showMessage"]);
                                                    }else{
                                                        responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                    }

                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                }];
}

- (void)postMyFriendDeleteFriendFromGroupWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFriendDeleteFriendFromGroupWithParameters:parameters
                                                        success:^(id responObject) {
                                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                                responSuccess(responObject[@"showMessage"]);
                                                            }else{
                                                                responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                            }
                                                        } failure:^(NSError *error) {
                                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                        }];
}

- (void)postMyAttentionListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyAttentionListWithParameters:parameters
                                          success:^(id responObject) {
                                              if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                  NSArray *data = responObject[@"data"][@"myIdosList"];
                                                  NSMutableArray *newData = [[NSMutableArray alloc] init];
                                                  for (NSDictionary *dict in data) {
                                                      FriendUserModel *model = [FriendUserModel mj_objectWithKeyValues:dict];
                                                      [newData addObject:model];
                                                  }
                                                  NSDictionary *dict = @{@"data":newData, @"count":responObject[@"data"][@"idosCount"]};
                                                  responSuccess(dict);
                                              }else{
                                                  responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                              }
                                          } failure:^(NSError *error) {
                                              responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                          }];
}


- (void)postMyAttentionCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyAttentionCountWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   responSuccess(responObject[@"data"][@"idosCount"]);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                           }];
}

- (void)postMyFansListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFansListWithParameters:parameters
                                     success:^(id responObject) {
                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                             NSArray *data = responObject[@"data"][@"myFollowsList"];
                                             NSMutableArray *newData = [[NSMutableArray alloc] init];
                                             for (NSDictionary *dict in data) {
                                                 FriendUserModel *model = [FriendUserModel mj_objectWithKeyValues:dict];
                                                 [newData addObject:model];
                                             }
                                             NSDictionary *dict = @{@"data":newData, @"count":responObject[@"data"][@"followsCount"]};
                                             responSuccess(dict);
                                         }else{
                                             responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                         }
                                     } failure:^(NSError *error) {
                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                     }];
}

- (void)postMyFansCountWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFansCountWithParameters:parameters
                                      success:^(id responObject) {
                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                              responSuccess(responObject[@"data"][@"followsCount"]);
                                          }else{
                                              responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                          }
                                      } failure:^(NSError *error) {
                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                      }];
}

- (void)postMyAttentionAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyAttentionAddWithParameters:parameters
                                         success:^(id responObject) {
                                             if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                 responSuccess(responObject[@"showMessage"]);
                                             }else{
                                                 responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                             }
                                         } failure:^(NSError *error) {
                                             responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                         }];
}

- (void)postMyAttentionRemoveWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyAttentionRemoveWithParameters:parameters
                                            success:^(id responObject) {
                                                if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                    responSuccess(responObject[@"showMessage"]);
                                                }else{
                                                    responFailure([responObject[@"status"] integerValue], responObject[@"showMessage"]);
                                                }
                                            } failure:^(NSError *error) {
                                                responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                            }];
}


- (void)postMyFavoritePlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFavoritePlaceListWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      NSMutableArray *data = [[NSMutableArray alloc] init];
                                                      for (NSDictionary *dict in responObject[@"data"]) {
                                                          
                                                          PlaceItemModel *model = [PlaceItemModel mj_objectWithKeyValues:dict];
                                                          [data addObject:model];
                                                      }
                                                      responSuccess(data);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }
                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                              }];
}

- (void)postMyFavoriteClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFavoriteClubListWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      NSMutableArray *data = [[NSMutableArray alloc] init];
                                                      for (NSDictionary *dict in responObject[@"data"]) {
                                                          
                                                          ClubArticle *model = [ClubArticle mj_objectWithKeyValues:dict];
                                                          [data addObject:model];
                                                      }
                                                      responSuccess(data);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }
                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                              }];

}

- (void)postMyFavoriteDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFavoriteDeleteWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   responSuccess(responObject[@"showMessage"]);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }

                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                           }];
}

- (void)postMyFavoriteAddWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyFavoriteAddWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                responSuccess(responObject[@"showMessage"]);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }
                                            
                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postMyClubHistoryHistoryClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubHistoryHistoryClubArticleListWithParameters:parameters
                                                              success:^(id responObject) {
                                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                                      NSMutableArray *obj = [[NSMutableArray alloc] init];
                                                                      for (NSDictionary *dict in responObject[@"data"]) {
                                                                          MyClubHistoryArcticleItemModel *itemModel = [MyClubHistoryArcticleItemModel mj_objectWithKeyValues:dict];
                                                                          [obj addObject:itemModel];
                                                                      }
                                                                      responSuccess(obj);
                                                                  }else{
                                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                                  }
 
                                                              } failure:^(NSError *error) {
                                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                              }];
}

- (void)postMyClubAgreeApplyWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubAgreeApplyWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   responSuccess(responObject[@"showMessage"]);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                           }];

}

- (void)postMyClubSelfDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubSelfDetailWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   MyClubModel *model = [MyClubModel mj_objectWithKeyValues:responObject[@"data"]];
                                                   responSuccess(model);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                           }];

}

- (void)postMyClubNewApplyUserListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    
    [_processor postMyClubNewApplyUserListWithParameters:parameters
                                                 success:^(id responObject) {
                                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                             NSMutableArray *obj = [[NSMutableArray alloc] init];
                                                             for (NSDictionary *dict in responObject[@"data"]) {
                                                                 MyClubNewJoinListModel *itemModel = [MyClubNewJoinListModel mj_objectWithKeyValues:dict];
                                                                 [obj addObject:itemModel];
                                                             }
                                                             responSuccess(obj);
                                                         }else{
                                                             responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                         }
                                                 } failure:^(NSError *error) {
                                                     responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                 }];
}

- (void)postMyClubNewApplyUserDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubNewApplyUserDetailWithParameters:parameters
                                                   success:^(id responObject) {
                                                       if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                            MyClubNewJoinListModel *detail = [MyClubNewJoinListModel mj_objectWithKeyValues:responObject[@"data"]];
                                                           responSuccess(detail);
                                                       }else{
                                                           responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                       }
                                                   } failure:^(NSError *error) {
                                                       responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                   }];
}

- (void)postMyClubJoinedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubJoinedListWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   NSArray *data = responObject[@"data"][@"dataList"];
                                                   NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                   for (NSDictionary *dict in data) {
                                                       MyClubItemModel *model = [MyClubItemModel mj_objectWithKeyValues:dict];
                                                       [obj addObject:model];
                                                   }
                                                   responSuccess(obj);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                           }];
}

- (void)postMyClubCreatedListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubCreatedListWithParameters:parameters
                                            success:^(id responObject) {
                                                if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                    NSArray *data = responObject[@"data"][@"dataList"];
                                                    NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                    for (NSDictionary *dict in data) {
                                                        MyClubItemModel *model = [MyClubItemModel mj_objectWithKeyValues:dict];
                                                        [obj addObject:model];
                                                    }
                                                    responSuccess(obj);
                                                }else{
                                                    responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                }
                                            } failure:^(NSError *error) {
                                                responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                            }];
}

- (void)postMyClubCreateNewWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubCreateNewWithParameters:parameters
                                          success:^(id responObject) {
                                              if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                  responSuccess(responObject[@"showMessage"]);
                                              }else{
                                                  responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                              }

                                          } failure:^(NSError *error) {
                                              responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                          }];
}

- (void)postMyClubDismissWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubDismissWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                responSuccess(responObject[@"showMessage"]);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }

                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                        }];
}

- (void)postMyClubExitWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubExitWithParameters:parameters
                                     success:^(id responObject) {
                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                             responSuccess(responObject[@"showMessage"]);
                                         }else{
                                             responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                         }

                                     } failure:^(NSError *error) {
                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                     }];
}

- (void)postMyClubRefuseWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyClubRefuseWithParameters:parameters
                                       success:^(id responObject) {
                                           if ([responObject[@"status"] isEqualToNumber:@1]) {
                                               responSuccess(responObject[@"showMessage"]);
                                           }else{
                                               responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                           }

                                       } failure:^(NSError *error) {
                                           responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                       }];
}

- (void)postMyBirdWalletFillRecordWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyBirdWalletFillRecordWithParameters:parameters
                                                 success:^(id responObject) {
                                                     if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                         NSArray *data = responObject[@"data"];
                                                         NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                         for (NSDictionary *dict in data ) {
                                                             MyBirdWalletFillRecordModel *model = [MyBirdWalletFillRecordModel mj_objectWithKeyValues:dict];
                                                             [obj addObject:model];
                                                         }
                                                         responSuccess(obj);
                                                     }else{
                                                         responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                     }

                                                 } failure:^(NSError *error) {
                                                     responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                                 }];
}


- (void)postMyBirdWalletFillWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyBirdWalletFillWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   responSuccess(responObject[@"data"]);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                           }];
}

- (void)postMyBirdWalletFillRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyBirdWalletFillRuleWithParameters:parameters
                                               success:^(id responObject) {
                                                   if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                       NSArray *data = responObject[@"data"];
                                                       NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                       for (NSDictionary *dict in data ) {
                                                           MyBirdWalletFillRuleModel *model = [MyBirdWalletFillRuleModel mj_objectWithKeyValues:dict];
                                                           [obj addObject:model];
                                                       }
                                                       responSuccess(obj);
                                                   }else{
                                                       responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                   }
                                               } failure:^(NSError *error) {
                                                   responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                               }];
}


- (void)postMyLevelGradeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyLevelGradeListWithParameters:parameters
                                           success:^(id responObject) {
                                               if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                   MyLevelModel *model = [MyLevelModel mj_objectWithKeyValues:responObject[@"data"]];
                                                   responSuccess(model);
                                               }else{
                                                   responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                               }
                                           } failure:^(NSError *error) {
                                               responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                           }];
}

- (void)postMyLevelUpWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyLevelUpWithParameters:parameters
                                    success:^(id responObject) {
                                        if ([responObject[@"status"] isEqualToNumber:@1]) {
                                            responSuccess(responObject[@"data"]);
                                        }else{
                                            responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                        }
                                    } failure:^(NSError *error) {
                                        responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                    }];
}

- (void)postMyArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyArticleListWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                NSArray *data = responObject[@"data"];
                                                NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                for (NSDictionary *dict in data ) {
                                                    MyArticleItemModel *model = [MyArticleItemModel mj_objectWithKeyValues:dict];
                                                    [obj addObject:model];
                                                }
                                                responSuccess(obj);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }

                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postMyArticleDeleteWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyArticleDeleteWithParameters:parameters
                                          success:^(id responObject) {
                                              if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                  responSuccess(responObject[@"showMessage"]);
                                              }else{
                                                  responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                              }
                                          } failure:^(NSError *error) {
                                              responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                          }];
}

- (void)postMyOrderListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderListWithParameters:parameters
                                      success:^(id responObject) {
                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                              NSArray *data = responObject[@"data"];
                                              NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                              for (NSDictionary *dict in data ) {
                                                  MyOrderListItemModel *model = [MyOrderListItemModel mj_objectWithKeyValues:dict];
                                                  [obj addObject:model];
                                              }
                                              responSuccess(obj);
                                          }else{
                                              responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                          }
                                      }
                                      failure:^(NSError *error) {
                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                      }];
}

- (void)postMyOrderCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderCancelWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                responSuccess(responObject[@"showMessage"]);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }

                                        }
                                        failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                        }];

}
- (void)postMyOrderUseParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderUseParameters:parameters
                                 success:^(id responObject) {
                                     if ([responObject[@"status"] isEqualToNumber:@1]) {
                                         responSuccess(responObject[@"showMessage"]);
                                     }else{
                                         responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                     }
 
                                 } failure:^(NSError *error) {
                                     responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                 }];
}

- (void)postMyOrderJugeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderJugeWithParameters:parameters
                                      success:^(id responObject) {
                                          if ([responObject[@"status"] isEqualToNumber:@1]) {
                                              responSuccess(responObject[@"showMessage"]);
                                          }else{
                                              responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                          }

                                      } failure:^(NSError *error) {
                                          responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                      }];

}

- (void)postMyOrderPayWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderPayWithParameters:parameters
                                     success:^(id responObject) {
                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                             responSuccess(responObject[@"data"]);
                                         }else{
                                             responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                         }

                                     } failure:^(NSError *error) {
                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                     }];

}

- (void)postMyOrderDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderDetailWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                MyOrderListItemModel *detailModel = [MyOrderListItemModel mj_objectWithKeyValues:responObject[@"data"]];
                                                responSuccess(detailModel);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }
                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postMyOrderReturnRuleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderReturnRuleWithParameters:parameters
                                            success:^(id responObject) {
                                                if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                    responSuccess(responObject[@"data"]);
                                                }else{
                                                    responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                }
                                            } failure:^(NSError *error) {
                                                responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                            }];
}

- (void)postMyOrderApplyReturnWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderApplyReturnWithParameters:parameters
                                             success:^(id responObject) {
                                                 if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                     responSuccess(responObject[@"showMessage"]);
                                                 }else{
                                                     responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                 }
                                             } failure:^(NSError *error) {
                                                 responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                             }];
}

- (void)postMyOrderReturnCancelWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyOrderReturnCancelWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      responSuccess(responObject[@"showMessage"]);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }
                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                              }];
}

- (void)postMyMessageListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyMessageListWithParameters:parameters
                                        success:^(id responObject) {
                                            if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                NSArray *data = responObject[@"data"];
                                                NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                for (NSDictionary *dict in data ) {
                                                    MyMessageItemModel *model = [MyMessageItemModel mj_objectWithKeyValues:dict];
                                                    [obj addObject:model];
                                                }
                                                responSuccess(obj);
                                            }else{
                                                responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                            }
                                        } failure:^(NSError *error) {
                                            responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                        }];
}

- (void)postMyMessageSystemListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyMessageSystemListWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      //模型数据解析
                                                      NSArray *data = responObject[@"data"];
                                                      NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                      for (NSDictionary *dict in data ) {
                                                          MyMessageSysModel *model = [MyMessageSysModel mj_objectWithKeyValues:dict];
                                                          [obj addObject:model];
                                                      }
                                                      responSuccess(obj);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }
                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                  
                                              }];
}
- (void)postMyMessageDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyMessageDeleteListWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      responSuccess(responObject[@"showMessage"]);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }
                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                              }];
}

- (void)postMyMessageSystemDeleteListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyMessageSystemDeleteListWithParameters:parameters
                                                    success:^(id responObject) {
                                                        if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                            responSuccess(responObject[@"showMessage"]);
                                                        }else{
                                                            responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                        }
                                                    } failure:^(NSError *error) {
                                                        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                        
                                                    }];
}

- (void)postMyMessageSystemNewNumWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyMessageSystemNewNumWithParameters:parameters
                                                success:^(id responObject) {
                                                    //模型数据解析
                                                    MyMessageSysNumModel *model = [MyMessageSysNumModel mj_objectWithKeyValues:responObject[@"data"]];;
                                                    responSuccess(model);
                                                    
                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                }];
}

- (void)postMyPointsConvertListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyPointsConvertListWithParameters:parameters
                                              success:^(id responObject) {
                                                  if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                      //模型数据解析
                                                      NSArray *data = responObject[@"data"];
                                                      NSMutableArray *obj  = [[NSMutableArray alloc] init];
                                                      for (NSDictionary *dict in data ) {
                                                          MyPointsModel *model = [MyPointsModel mj_objectWithKeyValues:dict];
                                                          [obj addObject:model];
                                                      }
                                                      responSuccess(obj);
                                                  }else{
                                                      responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                  }

                                              } failure:^(NSError *error) {
                                                  responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                              }];
}

- (void)postMyPointsConverServiceWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postMyPointsConverServiceWithParameters:parameters
                                                success:^(id responObject) {
                                                    if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                        responSuccess(responObject[@"showMessage"]);
                                                    }else{
                                                        responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                    }

                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);

                                                }];
}


- (void)postReportWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postReportWithParameters:parameters
                                                success:^(id responObject) {
                                                    if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                        responSuccess(responObject[@"showMessage"]);
                                                    }else{
                                                        responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                    }
                                                    
                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                    
                                                }];
}

@end

