import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String? productId;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? imageUrl;
  final bool? isIndividual;
  final String? path;
  final bool? isFavorite;
  final bool? isPopular;
  final String? productCategoryName;
  final String? videoLength;

  Product({
    this.productId,
    this.title,
    this.description,
    this.videoUrl,
    this.imageUrl,
    this.isIndividual,
    this.isFavorite,
    this.videoLength,
    this.path,
    this.isPopular,
    this.productCategoryName,
  });
  factory Product.fromDocument(doc) {
    return Product(
        productId: doc.data()["productId"],
        title: doc.data()["productTitle"],
        description: doc.data()["productDescription"],
        videoUrl: doc.data()["videoUrl"],
        path: doc.data()["path"],
        imageUrl: doc.data()["productImage"],
        videoLength: doc.data()["videoLength"],
        isFavorite: doc.data()["isFavorite"],
        productCategoryName: doc.data()["productCategory"],
        isPopular: true);
  }

  get id => null;
}
