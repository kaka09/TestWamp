
@protocol WampDelegate <NSObject>

@optional

- (void)didReceiverMessage:(BOOL)success andResult:(id)result;


@end

