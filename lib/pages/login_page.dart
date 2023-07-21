import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/welcom_page.dart';
import 'package:todo_list/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textFieldFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final statesController = MaterialStatesController();
  final stateContry = MaterialStatesController();

  Country selectedCountry = Country(
    phoneCode: "33",
    countryCode: "FR",
    displayName: 'France',
    e164Key: '',
    name: 'France',
    e164Sc: 0,
    displayNameNoCountryCode: '+33',
    example: 'France',
    geographic: true,
    level: 1,
  );
  @override
  Widget build(BuildContext context) {
    statesController.update(
      MaterialState.disabled,
      true, // or false depending on your logic
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _goBack(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Verified your phone number",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Form(
                    key: _textFieldFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      autofocus: true,
                      controller: phoneController,
                      decoration: InputDecoration(
                          icon: Container(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      onSelect: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                        });
                                      });
                                },
                                child: Text(
                                    "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}"),
                              )),
                          hintText: "0610101010",
                          labelText: "Your phone number"),
                      keyboardType: TextInputType.number,
                      maxLength: 14,
                      validator: (value) {
                        if (value!.isEmpty) {
                          statesController.update(
                            MaterialState.disabled,
                            true, // or false depending on your logic
                          );
                          return 'Please enter your phone number';
                        }
                        if (value.length < 9) {
                          statesController.update(
                            MaterialState.disabled,
                            true, // or false depending on your logic
                          );
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 30),
                TextButton.icon(
                    onPressed: () => sendPhoneNumber(),
                    statesController: statesController,
                    icon: const Icon(
                      Icons.send,
                      size: 24.0,
                    ),
                    label: const Text(
                      'test',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      disabledForegroundColor:
                          const Color.fromARGB(255, 255, 255, 255),
                      disabledBackgroundColor:
                          const Color.fromARGB(255, 165, 225, 255),
                    )),
                // RoundedLoadingButton(
                //   color: Colors.redAccent,
                //   successColor: Colors.green,
                //   controller: _verifyBtnController,
                //   onPressed: () => _sendOtpCodeWithFirebase(),
                //   child: const Text('Send code',
                //       style: TextStyle(color: Colors.white)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goBack(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomPage(),
        ));
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  }
}
