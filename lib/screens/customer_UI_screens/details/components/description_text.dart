import 'package:bookario/components/constants.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(6),
      ),
      child: secondHalf!.isEmpty
          ? Text(
              firstHalf!,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: Colors.white),
            )
          : Column(
              children: <Widget>[
                Text(
                  flag ? ("${firstHalf!}...") : (firstHalf! + secondHalf!),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(color: Colors.white),
                ),
                InkWell(
                  child: Row(
                    children: <Widget>[
                      Text(
                        flag ? "Read more" : "show less",
                        style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
