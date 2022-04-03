import 'package:salary_tracking_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import 'feedsdialog.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    print(productsAttributes);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        // onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
        //     arguments: productsAttributes.productId),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          // MediaQuery.of(context).size.height * 0.2,
                          child: Image.network(
                            productsAttributes.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        // bottom: 0,
                        // right: 5,
                        // top: 5,
                        child: Badge(
                          alignment: Alignment.center,
                          toAnimate: true,
                          shape: BadgeShape.square,
                          badgeColor: Colors.pink,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8)),
                          badgeContent: Text('New',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productsAttributes.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '\$ ${productsAttributes.videoUrl}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
