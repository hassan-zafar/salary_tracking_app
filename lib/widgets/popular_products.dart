import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salary_tracking_app/models/product.dart';
import 'package:salary_tracking_app/provider/favs_provider.dart';
import 'package:salary_tracking_app/widgets/product_details.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final String description;
  // final double price;

  // const PopularProducts(
  //     {Key key, this.imageUrl, this.title, this.description, this.price})
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    final favsProvider = Provider.of<FavsProvider>(context);
    var star_outlined;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                10.0,
              ),
              bottomRight: Radius.circular(10.0),
            ),
            // onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            //     arguments: productsAttributes.productId),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(productsAttributes.imageUrl!),
                              fit: BoxFit.contain)),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        FontAwesomeIcons.star,
                        color: favsProvider.getFavsItems
                                .containsKey(productsAttributes.productId)
                            ? Colors.red
                            : Colors.grey.shade800,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 8,
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 32.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          '\$ ${productsAttributes.videoUrl}',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsAttributes.title!,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              productsAttributes.description!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
