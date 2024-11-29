import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftNavBar extends StatefulWidget {
  final String selectedItem;
  final Function(String) onNavItemSelected;
  final bool isDarkTheme;
  final VoidCallback onThemeChanged;

  const LeftNavBar({
    required this.selectedItem,
    required this.onNavItemSelected,
    required this.isDarkTheme,
    required this.onThemeChanged,
  });

  @override
  _LeftNavBarState createState() => _LeftNavBarState();
}

class _LeftNavBarState extends State<LeftNavBar> {
  String? hoveredItem;

  final List<Map<String, dynamic>> navItems = [
    {'label': 'Home', 'icon': FontAwesomeIcons.home},
    {'label': 'About', 'icon': FontAwesomeIcons.circleUser},
    {'label': 'Projects', 'icon': FontAwesomeIcons.barsProgress},
    {'label': 'Services', 'icon': FontAwesomeIcons.servicestack},
    {'label': 'Contact', 'icon': FontAwesomeIcons.contactCard},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkTheme;
    final primaryColor = isDark ? Theme.of(context).primaryColor : Colors.blueGrey;

    return Container(
      width: 100,
      color: isDark ? const Color(0xFF1F1F21) : const Color(0xFFE8F1F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo at the Top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image(image:AssetImage("assets/logo.png"))
            ),
          ),

          // Navigation Icons
          Column(
            
            children: navItems.map((item) {
              final isSelected = widget.selectedItem == item['label'];
              final isHovered = hoveredItem == item['label'];

              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () => widget.onNavItemSelected(item['label']),
                  onHover: (hovering) {
                    setState(() {
                      hoveredItem = hovering ? item['label'] : null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Icon(
                      item['icon'],
                      color: isSelected || isHovered
                          ? primaryColor
                          : isDark
                              ? Colors.grey[400]
                              : Colors.grey[700],
                      size: 24, // Reduced icon size
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // Theme Toggle Button at the Bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: InkWell(
              onTap: widget.onThemeChanged,
              child: Icon(
                widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                size: 40, // Reduced icon size
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
