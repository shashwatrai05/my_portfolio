import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Map<String, bool> hoveredSkills = {};

  Future<void> _launchResume() async {
    final resumeUrl = 'https://firebasestorage.googleapis.com/v0/b/flutter-chat-ec3a8.appspot.com/o/Resume-%20Shashwat%20Rai.pdf?alt=media&token=5a8339a5-2ef2-4560-8ff5-9466ff779783';
    if (await canLaunch(resumeUrl)) {
      await launch(resumeUrl, forceWebView: false, forceSafariVC: false);
    } else {
      throw 'Could not launch $resumeUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Section
              isMobile
                  ? Column(
                      children: [
                        buildProfileImage(),
                        const SizedBox(height: 20),
                        buildProfileDescription(theme, isDarkTheme),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildProfileImage(),
                        const SizedBox(width: 20),
                        Expanded(child: buildProfileDescription(theme, isDarkTheme)),
                      ],
                    ),
              const SizedBox(height: 40),

              // Skills Section
              Text(
                "Skills",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  skillCard("Flutter", FontAwesomeIcons.mobile, theme, isDarkTheme),
                  skillCard("Dart", FontAwesomeIcons.code, theme, isDarkTheme),
                  skillCard("Firebase", FontAwesomeIcons.fire, theme, isDarkTheme),
                  skillCard("C", FontAwesomeIcons.c, theme, isDarkTheme),
                  skillCard("Java", FontAwesomeIcons.java, theme, isDarkTheme),
                  skillCard("Python", FontAwesomeIcons.python, theme, isDarkTheme),
                  skillCard("UI/UX Design", FontAwesomeIcons.paintBrush, theme, isDarkTheme),
                  skillCard("Figma", FontAwesomeIcons.figma, theme, isDarkTheme),
                ],
              ),
              const SizedBox(height: 40),

              // Metrics Section
              isMobile
                  ? Column(
                      children: [
                        metricCard("Projects", "15+", FontAwesomeIcons.listCheck, theme, isDarkTheme),
                        const SizedBox(height: 20),
                        metricCard("Internships", "3+", FontAwesomeIcons.laptopCode, theme, isDarkTheme),
                        const SizedBox(height: 20),
                        metricCard("Experience", "1 year", FontAwesomeIcons.userClock, theme, isDarkTheme),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        metricCard("Projects", "15+", FontAwesomeIcons.listCheck, theme, isDarkTheme),
                        metricCard("Internships", "3+", FontAwesomeIcons.laptopCode, theme, isDarkTheme),
                        metricCard("Experience", "1 year", FontAwesomeIcons.userClock, theme, isDarkTheme),
                      ],
                    ),
              const SizedBox(height: 40),

              // Download Resume Button
              ElevatedButton.icon(
                onPressed: _launchResume,
                icon: const Icon(
                  FontAwesomeIcons.download,
                  size: 18,
                ),
                label: const Text("Download Resume"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: isDarkTheme ? Colors.black : Colors.white,
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 6,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        'https://res.cloudinary.com/dwlqu09lf/image/upload/v1732892060/avatar4_kj3w55.png',
        width: isMobile? 150:300,
        height: isMobile? 150:300,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildProfileDescription(ThemeData theme, bool isDarkTheme) {
  // Determine screen width and check if it is mobile
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 600;

  return Column(
    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    children: [
      Text(
        "Hello, I'm Shashwat Rai",
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        "Currently pursuing a B.Tech in Computer Science and Engineering at KIET, Ghaziabad. I specialize in app development with Flutter & Firebase, and I’m proficient in C, Java, and Python. I also have expertise in UI/UX design using Figma.",
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isDarkTheme ? Colors.white70 : Colors.black54,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        "I have hands-on experience from internships at Ambuvians Healthcare and Roomsvital, and I currently serve as the Technical Lead at E-Cell KIET, App Development Captain at GDSC KIET, and MyGov India Campus Ambassador.",
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isDarkTheme ? Colors.white70 : Colors.black54,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        "I've demonstrated leadership by leading teams in hackathons, organizing events, and serving as a core member of several tech communities. I'm also the Lead Organizer for E-Summit 2024 and SprintHacks 2.0.",
        textAlign: isMobile ? TextAlign.center : TextAlign.start,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isDarkTheme ? Colors.white70 : Colors.black54,
          height: 1.6,
        ),
      ),
    ],
  );
}


  Widget skillCard(String label, IconData icon, ThemeData theme, bool isDarkTheme) {
    final skillKey = label; // Use skill name as the key for hover state

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredSkills[skillKey] = true),
      onExit: (_) => setState(() => hoveredSkills[skillKey] = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isDarkTheme
              ? Colors.white.withOpacity(0.1)
              : Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDarkTheme ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        transform: hoveredSkills[skillKey] == true
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isDarkTheme ? Colors.white : Colors.blueAccent, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget metricCard(String label, String value, IconData icon, ThemeData theme, bool isDarkTheme) {
    return Column(
      children: [
        Icon(icon, size: 30, color: isDarkTheme ? Colors.white : Colors.blueAccent),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDarkTheme ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
