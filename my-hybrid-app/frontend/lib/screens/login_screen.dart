import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import 'sharer_dashboard.dart';
import 'recipient_dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final appState = Provider.of<AppState>(context, listen: false);
            Widget destination;
            if (appState.userRole != null && appState.userRole.toString().contains('recipient')) {
              destination = const RecipientDashboard();
            } else {
              destination = const SharerDashboard();
            }
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => destination),
              (route) => false,
            );
          },
        ),
        title: const Text('Login', style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
        backgroundColor: const Color(0xFFFFF9EC),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFF9EC),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.20,
              child: Image.asset(
                'assets/images/food.png',
                fit: BoxFit.cover,
                height: 220,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.20,
              child: Image.asset(
                'assets/images/food.png',
                fit: BoxFit.cover,
                height: 220,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                  ),
                ),
                const Text('Login to your account', style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                TextField(
                  style: TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  style: TextStyle(fontFamily: 'Poppins'),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4E342E),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Login', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  },
                  child: const Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF00296B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      onPopInvoked: (_) {

        final appState = Provider.of<AppState>(context, listen: false);
        Widget destination;
        if (appState.userRole != null && appState.userRole.toString().contains('recipient')) {
          destination = const RecipientDashboard();
        } else {
          destination = const SharerDashboard();
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => destination),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final appState = Provider.of<AppState>(context, listen: false);
              Widget destination;
              if (appState.userRole != null && appState.userRole.toString().contains('recipient')) {
                destination = const RecipientDashboard();
              } else {
                destination = const SharerDashboard();
              }
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => destination),
                (route) => false,
              );
            },
          ),
          title: const Text('Register', style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
          backgroundColor: const Color(0xFFFFF9EC),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFFFF9EC),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Opacity(
                opacity: 0.20,
                child: Image.asset(
                  'assets/images/food.png',
                  fit: BoxFit.cover,
                  height: 220,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.20,
                child: Image.asset(
                  'assets/images/food.png',
                  fit: BoxFit.cover,
                  height: 220,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                    ),
                  ),
                  const Text('Create a new account', style: TextStyle(fontFamily: 'Poppins', fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 32),
                  TextField(
                    style: TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    style: TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'Poppins'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4E342E), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4E342E),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Register', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already have account? Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF00296B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
