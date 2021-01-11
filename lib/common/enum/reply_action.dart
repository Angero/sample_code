enum ReplyAction {
  Offensive,
  Nudity,
  Promotes,
  Hate,
  Suicide,
  False,
  Unauthorized,
  Block,
  Remove,
}

extension ReplyActionExtension on ReplyAction {
  String get itemTitle {
    switch (this) {
      case ReplyAction.Offensive:
        return 'Offensive Language';
      case ReplyAction.Nudity:
        return 'Nudity';
      case ReplyAction.Promotes:
        return 'Promotes violence or terrorism';
      case ReplyAction.Hate:
        return 'Hate Speech ';
      case ReplyAction.Suicide:
        return 'Suicide or self injury ';
      case ReplyAction.False:
        return 'False News';
      case ReplyAction.Unauthorized:
        return 'Unauthorized sales';
      case ReplyAction.Block:
        return 'Block User';
      case ReplyAction.Remove:
        return 'Remove From Contacts';
      default:
        return null;
    }
  }
}
