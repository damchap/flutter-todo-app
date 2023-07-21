import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/pages/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/pages/home_page.dart';
import 'package:todo_list/provider/auth_provider.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/ilustration_welcom.svg',
                      height: 500),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Plan your tasks every day',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Plan, manage and track all your team\'s tasks in one flexible visual app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      ap.isSignedIn == true
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                    },
                    child: const Text('get Started'),
                  )),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 22, 22));
  }
}
