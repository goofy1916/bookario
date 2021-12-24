import 'package:bookario/app.locator.dart';
import 'package:bookario/app.router.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/hovering_back_button.dart';
import 'package:bookario/components/size_config.dart';
import 'package:bookario/models/event_model.dart';
import 'package:bookario/screens/customer_UI_screens/details/details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'club_description.dart';

class Body extends StatelessWidget {
  final Event event;

  const Body({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailsScreenViewModel>.reactive(
        onModelReady: (viewModel) => viewModel.setEvent(event),
        viewModelBuilder: () => DetailsScreenViewModel(),
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: event.id,
                            child: Image.network(
                              event.eventThumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const HoveringBackButton(),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: getProportionateScreenWidth(10)),
                        padding: EdgeInsets.only(
                          top: getProportionateScreenWidth(15),
                          left: getProportionateScreenWidth(20),
                          right: getProportionateScreenWidth(20),
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              viewModel.busy("clubName")
                                  ? "Club"
                                  : viewModel.clubName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              '(${event.location})',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            EventDescription(
                                event: event, viewModel: viewModel),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            // TODO: Display remaining stags here
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.15,
                      right: SizeConfig.screenWidth * 0.15,
                      bottom: getProportionateScreenWidth(5),
                      top: getProportionateScreenWidth(5),
                    ),
                    child: DefaultButton(
                      text: "Get Pass",
                      press: event.remainingPasses > 0
                          ? () => {
                                locator<NavigationService>().navigateTo(
                                    Routes.bookPass,
                                    arguments: BookPassArguments(
                                        event: event,
                                        promoterId: viewModel.promoterId.text,
                                        coupon: viewModel.selectedCoupon)),
                              }
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
