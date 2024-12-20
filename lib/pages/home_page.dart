import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'contact_page.dart'; // Import your ContactPage here
import 'package:url_launcher/url_launcher.dart'; // Required for launching URLs

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHoveredContact = false;
  Map<String, bool> hoveredSocialIcons = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600; // Define a breakpoint for mobile

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkTheme
              ? [const Color(0xFF1F1F21), const Color(0xFF282A36)]
              : [const Color(0xFFE8F1F2), const Color(0xFFD1E8E2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Image
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: isMobile ? 120 : 200, // Adjust size for mobile
                height: isMobile ? 120 : 200, // Adjust size for mobile
                child: Image.network(
                  "https://res.cloudinary.com/dwlqu09lf/image/upload/v1732892060/avatar4_kj3w55.png",
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Name and Developer Info
            Column(
              children: [
                Text(
                  "Hi, I'm Shashwat!",
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 32, // Adjust font size for mobile
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Passionate Flutter Developer',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20, // Adjust font size for mobile
                    fontWeight: FontWeight.w300,
                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Contact Me Button
            MouseRegion(
              onEnter: (_) => setState(() => isHoveredContact = true),
              onExit: (_) => setState(() => isHoveredContact = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: isHoveredContact
                    ? Matrix4.translationValues(0, -4, 0)
                    : Matrix4.identity(),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 28.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Contact Me',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16, // Adjust font size for mobile
                      color: isDarkTheme ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Social Media Icons
            Wrap(
              alignment: WrapAlignment.center,
              spacing: isMobile ? 10 : 20, // Adjust spacing for mobile
              children: [
                _buildSocialIcon(
                  FontAwesomeIcons.linkedin,
                  'https://www.linkedin.com/in/shashwatrai05/',
                ),
                _buildSocialIcon(
                  FontAwesomeIcons.github,
                  'https://github.com/shashwatrai05',
                ),
                _buildSocialIcon(
                  FontAwesomeIcons.twitter,
                  'https://x.com/shashwatrai05',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSocialIcons[icon.toString()] = true),
      onExit: (_) => setState(() => hoveredSocialIcons[icon.toString()] = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: hoveredSocialIcons[icon.toString()] == true
              ? Matrix4.translationValues(0, -4, 0)
              : Matrix4.identity(),
          child: InkWell(
            onTap: () async {
              final uri = Uri.parse(url);
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: CircleAvatar(
              radius: isMobile ? 20 : 25, // Adjust size for mobile
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Icon(
                icon,
                color: Colors.grey[700],
                size: isMobile ? 16 : 20, // Adjust icon size for mobile
              ),
            ),
          ),
        ),
      ),
    );
  }
}
