import 'package:flutter/material.dart';

class DetailInfoTile extends StatelessWidget {

  final String title;

  final String data;

  final Widget icon;

  const DetailInfoTile({

    super.key,

    required this.title,

    required this.data,

    required this.icon,

  });



  @override

  Widget build(BuildContext context) {

    return Flexible(

      child: Row(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          CircleAvatar(backgroundColor: Colors.teal[100], child: icon),

          const SizedBox(width: 8.0),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                FittedBox(child: Text(title, )),

                FittedBox(

                  child: ConstrainedBox(

                    constraints: const BoxConstraints(minWidth: 1.0),

                    child: Text(

                      data,

                      style: const TextStyle(fontSize: 16.0),

                      maxLines: 1,

                    ),

                  ),

                ),

              ],

            ),

          )

        ],

      ),

    );

  }

}
