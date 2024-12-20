import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesPage extends StatefulWidget {
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Service> services = [
    Service(
      title: "  Mobile App\nDevelopment",
      description:
          "Creating high-performance apps for Android and iOS using modern technologies like Flutter and React Native.",
      icon: FontAwesomeIcons.mobileAlt,
    ),
    Service(
      title: "UI/UX Designing",
      description:
          "Crafting visually appealing and intuitive designs for applications, ensuring an optimal user experience.",
      icon: FontAwesomeIcons.pencilRuler,
    ),
    Service(
      title: "Frontend Development",
      description:
          "Building responsive and interactive user interfaces using HTML, CSS, and JavaScript frameworks like React and Angular.",
      icon: FontAwesomeIcons.code,
    ),
    Service(
      title: "Technical Management",
      description:
          "Managing projects and teams with a focus on delivering efficient technical solutions and ensuring timely delivery.",
      icon: FontAwesomeIcons.cogs,
    ),
  ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header section
            Text(
              "My Services",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Here are some of the services I offer to help you build impactful digital experiences.",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDarkTheme ? Colors.white70 : Colors.black54,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Responsive grid for service cards
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (screenWidth < 1024 ? 2 : 4),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 4, // Adjust aspect ratio for consistent shape
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(service: services[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String title;
  final String description;
  final IconData icon;

  Service({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ServiceCard extends StatefulWidget {
  final Service service;

  const ServiceCard({required this.service});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        width: 280, // Fixed width for consistency
        height: 200, // Fixed height for consistency
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              widget.service.icon,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              widget.service.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.service.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDarkTheme ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
