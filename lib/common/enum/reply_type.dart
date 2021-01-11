enum ReplyType {
  Comment,
  Profile,
  Dialogues,
}

extension ReplyTypeExtension on ReplyType {
  String get itemTitle {
    switch (this) {
      case ReplyType.Comment:
        return 'comment';
      case ReplyType.Profile:
        return 'profile';
      case ReplyType.Dialogues:
        return 'dialogues';
      default:
        return null;
    }
  }
}
