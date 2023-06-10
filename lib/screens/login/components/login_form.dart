import 'package:flutter/material.dart';
import 'package:kiuqi/app.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:kiuqi/providers/login_provider.dart';

import 'package:provider/provider.dart';

final TextEditingController phoneNumberController = TextEditingController();

bool isOtpScreen = false;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: context.watch<LoginProvider>().isOtpScreen
            ? otpField(context)
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  phoneNumberField(),
                  signinButton(),
                ],
              ),
      ),
    );
  }

  Widget otpField(BuildContext context) {
    LoginProvider loginProvider = Provider.of(context, listen: false);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Verification Code',
            style: BaseStyles.headingTextStyle,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'We texted you a code, Please enter it below',
            style: BaseStyles.textInputHintStyle,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        OtpTextField(
          numberOfFields: 4,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          enabledBorderColor: Colors.grey,
          focusedBorderColor: AppColor.primaryColor,
          showFieldAsBox: true,
          onSubmit: (String otp) async {
            bool status = await loginProvider.verifyOtp(otp);
            if (status) {

              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                  const SnackBar(content: Text("Successfully logged in...")));

              bool _userHasDetails = await loginProvider.checkUserHasData();
              loginProvider.disposeValues();
              if (_userHasDetails) {
                Navigator.of(navigatorKey.currentContext!)
                  .pushReplacementNamed('/discover');
              } else {
                Navigator.of(navigatorKey.currentContext!)
                  .pushReplacementNamed('/user-details');
              }    
              
            } else {
              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                  const SnackBar(content: Text("Incorrect OTP!!!")));
            }
          },
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          "Didn't get code?",
          style: BaseStyles.textInputHintStyle,
        ),
        Consumer<LoginProvider>(
          builder: ((context, value, _) {
            return TextButton(
              onPressed: !value.counterStatus
                  ? () {
                      value.sendOtp("", true);
                    }
                  : null,
              child: Text(
                value.counterString,
                style: const TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            );
          }),
        ),
        Text(
          'or',
          style: BaseStyles.textInputHintStyle,
        ),
        TextButton(
          onPressed: () {
            loginProvider.goToPhoneScreen();
          },
          child: const Text(
            "Change Phone Number",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneNumberField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Verification Code',
            style: BaseStyles.headingTextStyle,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'We will text you a verification code',
            style: BaseStyles.textInputHintStyle,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.inputFieldBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                CountryCodePicker(
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  enabled: false,
                  padding: const EdgeInsets.only(top: 5),
                ),
                const VerticalDivider(
                  thickness: 1,
                  indent: 18,
                  endIndent: 18,
                  width: 10,
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: phoneNumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(height: 2.0, fontSize: 20),
                    decoration: InputDecoration(
                      counterText: '',
                      fillColor: AppColor.inputFieldBackground,
                      filled: true,
                      hintText: 'Your Phone Number',
                      hintStyle: BaseStyles.textInputHintStyle,
                      border: BaseBorders.textInputBorder,
                    ),
                    onChanged: (String value) {
                      if (value.length == 10) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 90,
        )
      ],
    );
  }

  Widget signinButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Sign In',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColor.buttonColor,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: Colors.white,
            onPressed: () => context
                .read<LoginProvider>()
                .sendOtp(phoneNumberController.text.trim().toString(), false),
          ),
        )
      ],
    );
  }
}
