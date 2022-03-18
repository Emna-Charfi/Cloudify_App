import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/providers/cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanierGameCard extends StatelessWidget {
  final String? id;
  final String? productId;
  final String? title;
  final double? price;
  final String? image;
  Function? onCardClick;

  PanierGameCard(
      {this.id,
      this.productId,
      this.title,
      this.price,
      this.image,
      this.onCardClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          // padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId!);
        },
        child: SizedBox(
          // height: 150,
          // width: 200,
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 19,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: ClipOval(
                    child: Image.asset(
                  image!,
                  fit: BoxFit.contain,
                  matchTextDirection: true,
                  height: 100,
                  width: 100,
                )),
                title: Text(
                  title.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Total: \$${(price)}',
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.delete),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
