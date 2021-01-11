enum SegmentedTab { News, Recommendation }

extension HomeTabExtension on SegmentedTab {
  String get itemTitle {
    switch (this) {
      case SegmentedTab.News:
        return 'NEWS';
      case SegmentedTab.Recommendation:
        return 'RECOMMENDATION';
      default:
        return null;
    }
  }
}