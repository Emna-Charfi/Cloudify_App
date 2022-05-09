import 'package:cloudify_application/model/game_model.dart';
import 'package:cloudify_application/providers/cart.dart';
import 'package:cloudify_application/providers/games.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanierGameCard extends StatefulWidget {
  final String? id;
  final String? productId;
  final String? title;
  final int? price;
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
  State<PanierGameCard> createState() => _PanierGameCardState();
}

class _PanierGameCardState extends State<PanierGameCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.widget.onCardClick!();
      },
      child: Dismissible(
        key: ValueKey(widget.id),
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
        confirmDismiss: (direction) {
          return showDialog(
              context: this.context,
              builder: (context) => AlertDialog(
                    title: Text("Are you sure?"),
                    content:
                        Text("Do you want to remove the item from the Panier?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);

                          Provider.of<Cart>(this.context, listen: false)
                              .removeItem(widget.productId!);
                          Provider.of<Games>(this.context, listen: false)
                              .toggleFavoriteStatus(widget.productId!);

                          // Navigator.pushNamed(context, "/home/panier");
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ));
        },
        // onDismissed: (direction) {
        //   Provider.of<Cart>(context, listen: false).removeItem(productId!);
        // },
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
                    child: Image.network(
                  widget.image!,
                  fit: BoxFit.contain,
                  matchTextDirection: true,
                  height: 100,
                  width: 100,
                )),
                title: Text(
                  widget.title.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Total: \$${(widget.price)}',
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
