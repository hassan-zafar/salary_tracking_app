import 'package:salary_tracking_app/models/favs_attr.dart';
import 'package:flutter/cupertino.dart';

class FavsProvider with ChangeNotifier {
  Map<String, FavsAttr> _favsItems = {};

  Map<String, FavsAttr> get getFavsItems {
    return {..._favsItems};
  }

  void addAndRemoveFromFav(String productId, String videoUrl, String title,
      String imageUrl, String category) {
    if (_favsItems.containsKey(productId)) {
      removeItem(productId);
    } else {
      _favsItems.putIfAbsent(
          productId,
          () => FavsAttr(
              id: productId,
              title: title,
              videoUrl: videoUrl,
              category: category,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _favsItems.remove(productId);
    notifyListeners();
  }

  void clearFavs() {
    _favsItems.clear();
    notifyListeners();
  }
}
