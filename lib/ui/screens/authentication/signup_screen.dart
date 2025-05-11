import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../role_selection_screen.dart';
import 'login_screen.dart';
import '../../../service/auth_service.dart';

class SignupScreen extends StatefulWidget {
  final String role; // Role passed from RoleSelectionScreen

  const SignupScreen({required this.role, super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String? result = await _authService.signup(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: widget.role,
      );

      if (result == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Signup Successful! Please login as ${widget.role}',
              ),
              backgroundColor: RTColors.success,
              duration: const Duration(seconds: 3),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (_) => LoginScreen(
                    selectedRole: widget.role,
                  ), // Pass the role to LoginScreen
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup Failed: $result'),
              backgroundColor: RTColors.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: RTColors.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
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
      body: Padding(
        padding: const EdgeInsets.all(RTSpacings.l),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/person.png", height: 150),
                ),
                const SizedBox(height: RTSpacings.xl),

                // Show the role being signed up for
                Text(
                  "Signup as ${widget.role}",
                  style: RTTextStyles.heading.copyWith(color: RTColors.primary),
                ),
                const SizedBox(height: RTSpacings.s),
                Text(
                  "Create an account to get started.",
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
                      onPressed:
                          () => setState(
                            () => _isPasswordHidden = !_isPasswordHidden,
                          ),
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: RTColors.black,
                      ),
                    ),
                  ),
                  obscureText: _isPasswordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: RTSpacings.xl),

                // Signup Button
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
                        onPressed: _isLoading ? null : _signup,
                        child: Text(
                          "Signup as ${widget.role}",
                          style: RTTextStyles.button.copyWith(
                            color: RTColors.white,
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: RTSpacings.l),

                // Login Prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: RTTextStyles.body),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RoleSelectionScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login here",
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
