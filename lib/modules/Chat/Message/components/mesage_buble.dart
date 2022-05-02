import 'package:flutter/material.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';


class mesagebuble extends StatelessWidget {
  mesagebuble(this.mesage, this.username, this.useriamg, this.isme);

  final String mesage, username, useriamg;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
        isme ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isme) ...[
             CircleAvatar(radius: 12, backgroundImage: NetworkImage(useriamg),),
            const SizedBox(width: kDefaultPadding / 2),
          ],
         Container(
            padding:const  EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(isme ? 1 : 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              mesage,
              style: TextStyle(
                color: isme
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
         if (!isme) Container(
            margin:const EdgeInsets.only(left: kDefaultPadding / 2),
            height: 12,
            width: 12,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done,
              size: 8,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          )
        ],
      ),
    );
  }
}

