import 'package:flutter/material.dart';
import 'package:race_tracker/ui/screens/authentication/signup_screen.dart';
import '../../../service/auth_service.dart';
import '../../theme/theme.dart';
import 'package:race_tracker/ui/screens/manager/home_screen.dart';
import 'package:race_tracker/ui/screens/tracker/track_swimming_screen.dart';

class LoginScreen extends StatefulWidget {
  final String selectedRole;

  const LoginScreen({required this.selectedRole, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordHidden = true;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String? result = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        selectedRole: widget.selectedRole,
      );

      if (result == 'Manager') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else if (result == 'Tracker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TrackSwimmingScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result ?? 'Access denied'),
            backgroundColor: RTColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: RTColors.error,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RTColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(RTSpacings.l),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/person.png", height: 150),
                ),
                const SizedBox(height: RTSpacings.l),
                Text(
                  "Login as ${widget.selectedRole}",
                  style: RTTextStyles.heading.copyWith(color: RTColors.primary),
                ),
                const SizedBox(height: RTSpacings.s),
                Text(
                  "Sign in to access your account.",
                  style: RTTextStyles.subHeading.copyWith(
                    color: RTColors.black,
                  ),
                ),
                const SizedBox(height: RTSpacings.xl),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: RTTextStyles.body,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RTSpacings.radius),
                      borderSide: BorderSide(color: RTColors.greyLight),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: RTSpacings.m),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: RTTextStyles.body,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(RTSpacings.radius),
                      borderSide: BorderSide(color: RTColors.greyLight),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: RTColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                  obscureText: _isPasswordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: RTSpacings.xl),

                // Login Button
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RTColors.primary,
                          padding: const EdgeInsets.all(RTSpacings.m),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              RTSpacings.radius,
                            ),
                          ),
                        ),
                        onPressed: _login,
                        child: Text(
                          "Login",
                          style: RTTextStyles.button.copyWith(
                            color: RTColors.white,
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: RTSpacings.l),

                // Signup Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: RTTextStyles.body),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => SignupScreen(role: widget.selectedRole),
                          ),
                        );
                      },
                      child: Text(
                        "Signup here",
                        style: RTTextStyles.body.copyWith(
                          color: RTColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}