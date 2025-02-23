import 'package:bookario/screens/customer_UI_screens/profile/components/body.dart';
import 'package:bookario/screens/customer_UI_screens/profile/profile_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.populateDetails(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Image.asset(
                "assets/images/onlylogo.png",
                fit: BoxFit.cover,
              ),
            ),
            title: const Text("Profile"),
            actions: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  await viewModel.navigateToEditScreen();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ClipOval(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.edit,
                        size: 22,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Body(
            viewModel: viewModel,
          ),
        );
      },
      viewModelBuilder: () => ProfileScreenViewModel(),
    );
  }
}
