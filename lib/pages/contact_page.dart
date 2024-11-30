import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  Future<bool> _sendEmail(String name, String email, String subject, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': 'service_mqqwwht',
          'template_id': 'template_zw9h2hv',
          'user_id': 'Fw1JaWi8CImATBuGr',
          'template_params': {
            'user_name': name,
            'user_email': email,
            'subject': subject,
            'message': message,
          }
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    // Get screen width to adjust padding and form width
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final formPadding = isMobile ? 16.0 : 32.0; // Reduce padding for mobile

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkTheme
                ? [const Color(0xFF1F1F21), const Color(0xFF282A36)]
                : [const Color(0xFFE8F1F2), const Color(0xFFD1E8E2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: formPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    Text(
                      "Contact Me",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontSize: isMobile ? 24 : 32, // Dynamic font size for header
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Feel free to reach out to me via email or send a message using the form below.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                        height: 1.6,
                        fontSize: isMobile ? 14 : 18, // Dynamic font size for description
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Contact Form
                    Column(
                      children: [
                        // Name Input
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Your Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Email Input
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Your Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Subject Input
                        TextFormField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            labelText: "Subject",
                            prefixIcon: Icon(Icons.subject),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a subject';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        // Message Input
                        TextFormField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: "Your Message",
                            prefixIcon: Icon(Icons.message),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Send Button
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Handle send action
                              bool success = await _sendEmail(
                                _nameController.text,
                                _emailController.text,
                                _subjectController.text,
                                _messageController.text,
                              );
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Email Sent Successfully!')),
                                );
                                _nameController.clear();
                                _emailController.clear();
                                _subjectController.clear();
                                _messageController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Failed to send email.')),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text("Send Message", style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: theme.primaryColor,
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Email Text
                    Text(
                      "You can also reach me at: shashwatrai575@gmail.com", // Replace with your email
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDarkTheme ? Colors.white70 : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 14 : 18, // Adjust font size for mobile
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
