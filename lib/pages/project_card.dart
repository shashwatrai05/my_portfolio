import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class ProjectCard extends StatefulWidget {
  final Project project;
  final bool isPortrait;

  const ProjectCard({required this.project, required this.isPortrait});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  // Method to launch a URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // If the URL can't be launched, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open the link!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    // Image aspect ratio calculation based on project type (9:16 or 16:9)
    double imageWidth = widget.isPortrait ? 180 : 250;
    double imageHeight =
        widget.isPortrait ? 320 : 140; // 9:16 for portrait, 16:9 for landscape

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: imageWidth,
        height: imageHeight + 60, // Adding space for title
        child: Stack(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:Image.network(widget.project.imageUrl,
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            // Project Title Below Image
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.project.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Tech Stack Strap (Visible on Hover, top-left corner)
            if (_isHovered)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.project.techStack,
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Link Strap (Visible on Hover, bottom-right corner, with background)
            if (_isHovered &&
                (widget.project.projectLink.isNotEmpty ||
                    widget.project.githubLink.isNotEmpty))
              Positioned(
                bottom: 75, // Slightly moved up from the original position
                right: 8,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: theme.primaryColor, // Adding background color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // Show the project link icon if it's not empty
                        if (widget.project.projectLink.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              _launchURL(widget
                                  .project.projectLink); // Launch project link
                            },
                            icon: Icon(Icons.link, color: Colors.white),
                            iconSize: 18, // Adjust the size of the icon
                          ),
                        // Show the GitHub link icon if it's not empty
                        if (widget.project.githubLink.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              _launchURL(widget
                                  .project.githubLink); // Launch GitHub link
                            },
                            icon: Icon(Icons.code, color: Colors.white),
                            iconSize: 18, // Adjust the size of the icon
                          ),
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String techStack;
  final String projectLink;
  final String githubLink;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    required this.projectLink,
    required this.githubLink,
  });
}
