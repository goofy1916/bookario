import 'package:bookario/components/constants.dart';
import 'package:bookario/components/custom_suffix_icon.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/form_error.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/size_config.dart';
import 'package:bookario/screens/sign_up/components/bottom_text.dart';
import 'package:bookario/screens/sign_up/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (BuildContext context, SignUpViewModel viewModel, child) => Form(
        key: viewModel.formKey,
        child: viewModel.isBusy
            ? const Loading(text: "Please wait...\n Creating your account")
            : Column(
                children: [
                  buildNameFormField(viewModel, context),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  buildEmailFormField(viewModel, context),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  buildPhoneNumberFormField(viewModel, context),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  buildPasswordFormField(viewModel, context),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  buildConformPassFormField(viewModel, context),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  Row(
                    children: [
                      buildAgeFormField(viewModel, context),
                      SizedBox(
                        width: getProportionateScreenHeight(10),
                      ),
                      buildGenderFormField(viewModel, context)
                    ],
                  ),
                  // SizedBox(height: getProportionateScreenHeight(16)),
                  // buildUserTypeRadioButtons(viewModel, context),
                  FormError(errors: viewModel.errors),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DefaultButton(
                    text: "Register",
                    press: () async {
                      viewModel.validateAndSave();
                    },
                  ),
                  const SignupScreenBottomText()
                ],
              ),
      ),
    );
  }

  TextFormField buildNameFormField(
    SignUpViewModel viewModel,
    BuildContext context,
  ) {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: viewModel.nameFocusNode,
      onSaved: (newValue) => viewModel.name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          viewModel.removeError(error: "Please Enter your name");
        }
      },
      validator: (value) {
        if (value == null) {
          viewModel.addError(error: "Please Enter your name");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      onFieldSubmitted: (value) {
        viewModel.nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(viewModel.emailFocusNode);
      },
    );
  }

  TextFormField buildEmailFormField(
      SignUpViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: viewModel.emailFocusNode,
      onSaved: (newValue) => viewModel.email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          viewModel.removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          viewModel.removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          viewModel.addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          viewModel.addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      onFieldSubmitted: (value) {
        viewModel.emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(viewModel.phoneNumberFocusNode);
      },
    );
  }

  TextFormField buildPhoneNumberFormField(
      SignUpViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      keyboardType: TextInputType.phone,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: viewModel.phoneNumberFocusNode,
      onSaved: (newValue) => viewModel.phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          viewModel.removeError(error: "Please Enter your Phone Number");
        } else if (value.length == 10) {
          viewModel.removeError(error: "Please Enter valid Phone Number");
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          viewModel.addError(error: "Please Enter your Phone Number");
          return "";
        } else if (value.length != 10) {
          viewModel.addError(error: "Please Enter valid Phone Number");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Call-grey.svg"),
      ),
      onFieldSubmitted: (value) {
        viewModel.phoneNumberFocusNode.unfocus();
        FocusScope.of(context).requestFocus(viewModel.passwordFocusNode);
      },
    );
  }

  TextFormField buildPasswordFormField(
      SignUpViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      obscureText: viewModel.obscureText,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: viewModel.passwordFocusNode,
      onSaved: (newValue) => viewModel.password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          viewModel.removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          viewModel.removeError(error: kShortPassError);
        }
        viewModel.password = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          viewModel.addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          viewModel.addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
      onFieldSubmitted: (value) {
        viewModel.passwordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(viewModel.confirmPasswordFocusNode);
      },
    );
  }

  TextFormField buildConformPassFormField(
      SignUpViewModel viewModel, BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white70),
      obscureText: viewModel.obscureText,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: viewModel.confirmPasswordFocusNode,
      onSaved: (newValue) => viewModel.confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          viewModel.removeError(error: kPassNullError);
        } else if (value.isNotEmpty &&
            viewModel.password == viewModel.confirmPassword) {
          viewModel.removeError(error: kMatchPassError);
        }
        viewModel.confirmPassword = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          viewModel.addError(error: kPassNullError);
          return "";
        } else if (viewModel.password != value) {
          viewModel.addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: viewModel.obscureText
              ? GestureDetector(
                  onTap: () => viewModel.toggle(),
                  child: const FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    size: 17,
                    color: Colors.white70,
                  ),
                )
              : GestureDetector(
                  onTap: () => viewModel.toggle(),
                  child: const FaIcon(
                    FontAwesomeIcons.eye,
                    size: 17,
                    color: Colors.white70,
                  ),
                ),
        ),
      ),
      onFieldSubmitted: (value) {
        viewModel.confirmPasswordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(viewModel.ageFocusNode);
      },
    );
  }

  Expanded buildAgeFormField(SignUpViewModel viewModel, BuildContext context) {
    return Expanded(
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        cursorColor: Colors.white70,
        textInputAction: TextInputAction.done,
        focusNode: viewModel.ageFocusNode,
        onSaved: (newValue) => viewModel.age = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            viewModel.removeError(error: "Please Enter your age");
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            viewModel.addError(error: "Please Enter your age");
            return "";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: "Age",
          hintText: "Your Age",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Age.svg"),
        ),
        onFieldSubmitted: (value) {
          viewModel.ageFocusNode.unfocus();
          FocusScope.of(context).requestFocus(viewModel.genderFocusNode);
        },
      ),
    );
  }

  Expanded buildGenderFormField(
      SignUpViewModel viewModel, BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: viewModel.gender,
        dropdownColor: kSecondaryColor,
        style: const TextStyle(color: kPrimaryColor),
        onChanged: (String? value) {
          viewModel.gender = value;
        },
        items: ['Male', 'Female', 'Others']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        validator: (value) => value == null ? 'Select Gender' : null,
        decoration: const InputDecoration(
          labelText: 'Gender',
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  // Row buildUserTypeRadioButtons(SignUpViewModel viewModel, BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Radio<int>(
  //         activeColor: kPrimaryColor,
  //         value: 0,
  //         groupValue: viewModel.radioValue,
  //         onChanged: viewModel.handleRadioValueChange,
  //       ),
  //       Text(
  //         "Customer",
  //       ),
  //       Radio(
  //         activeColor: kPrimaryColor,
  //         value: 1,
  //         groupValue: viewModel.radioValue,
  //         onChanged: viewModel.handleRadioValueChange,
  //       ),
  //       Text(
  //         "Club",
  //       ),
  //     ],
  //   );
  // }

  // void _handleRadioValueChange(int value) {
  //   setState(() {
  //     _radioValue = value;

  //     switch (_radioValue) {
  //       case 0:
  //         _userType = 'customer';
  //         break;
  //       case 1:
  //         _userType = 'club';
  //         break;
  //     }
  //   });
  // }
}
