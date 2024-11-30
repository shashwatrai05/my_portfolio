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

    // Determine screen width and if it's mobile
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final double navWidth = isMobile ? 60 : 100;
    final double iconSize = isMobile ? 20 : 24;
    final double logoSize = isMobile ? 60 : 100;
    final EdgeInsetsGeometry padding = isMobile ? const EdgeInsets.all(4.0) : const EdgeInsets.all(8.0);

    return Container(
      width: navWidth,
      color: isDark ? const Color(0xFF1F1F21) : const Color(0xFFE8F1F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo at the Top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: logoSize,
              height: logoSize,
              child: Image.network(
                "https://res.cloudinary.com/dwlqu09lf/image/upload/v1732892157/logo_ggsdnb.png",
              ),
            ),
          ),

          // Navigation Icons
          Column(
            children: navItems.map((item) {
              final isSelected = widget.selectedItem == item['label'];
              final isHovered = hoveredItem == item['label'];

              return Padding(
                padding: padding,
                child: InkWell(
                  onTap: () => widget.onNavItemSelected(item['label']),
                  onHover: (hovering) {
                    setState(() {
                      hoveredItem = hovering ? item['label'] : null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Icon(
                      item['icon'],
                      color: isSelected || isHovered
                          ? primaryColor
                          : isDark
                              ? Colors.grey[400]
                              : Colors.grey[700],
                      size: iconSize,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // Theme Toggle Button at the Bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: widget.onThemeChanged,
              child: Icon(
                widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                size: iconSize + 10, // Slightly larger than other icons
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
