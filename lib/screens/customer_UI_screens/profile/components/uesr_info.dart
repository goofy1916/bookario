import 'package:bookario/components/loading.dart';
import 'package:bookario/components/size_config.dart';
import 'package:bookario/screens/customer_UI_screens/profile/profile_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class UserDetails extends StatelessWidget {
  final ProfileScreenViewModel viewModel;

  const UserDetails({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 15, color: Colors.white);
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                "Name",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Phone no.",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Email ID",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Age",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
              Text(
                "Gender",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          if (viewModel.isBusy)
            const Expanded(child: Loading())
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ":  ${viewModel.user.name}",
                  style: textStyle,
                ),
                Text(
                  ":  ${viewModel.user.phone}",
                  style: textStyle,
                ),
                Text(
                  ":  ${viewModel.user.email}",
                  style: textStyle,
                ),
                Text(
                  ":  ${viewModel.user.age} yrs",
                  style: textStyle,
                ),
                Text(
                  ":  ${viewModel.user.gender}",
                  style: textStyle,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
