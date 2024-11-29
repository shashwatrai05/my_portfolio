import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/project_card.dart';

class ProjectsPage extends StatelessWidget {
  final List<Project> appProjects = [
    Project(
      title: "E-CELL App",
      description: "A mobile app built using Flutter.",
      imageUrl: "Projects/E-Cell_App.jpeg",
      techStack: "Flutter, Dart, Firebase",
      projectLink: "",
      githubLink: "",
    ),
    Project(
      title: "Pardarsh App",
      description: "A cross-platform app developed with React Native.",
      imageUrl: "Projects/Pardarsh.jpeg",
      techStack: "Flutter, Dart, Firebase",
      projectLink: "",
      githubLink: "https://github.com/shashwatrai05/pardarsh",
    ),
    Project(
      title: "Uddeshhya ERP",
      description: "An iOS/Android app built with Swift and Kotlin.",
      imageUrl: "Projects/Uddeshyya.jpeg",
      techStack: "Flutter, Dart, Firebase",
      projectLink: "",
      githubLink: "",
    ),
  ];

  final List<Project> webProjects = [
    Project(
      title: "Market Watch",
      description: "A single-page application built using Angular.",
      imageUrl: "Projects/MarketWatch.png",
      techStack: "Flutter, Firebase",
      projectLink: "https://market-watch-c162a.web.app/#/",
      githubLink: "",
    ),
    Project(
      title: "E-CELL Web",
      description: "A responsive website built with React and Node.js.",
      imageUrl: "Projects/E-Cell_Web.png",
      techStack: "HTML,CSS,ReactJS,Node.js",
      projectLink: "https://e-cell.in/",
      githubLink: "",
    ),
    Project(
      title: "Pardarsh Dashboard",
      description: "A website built using HTML, CSS, and JavaScript.",
      imageUrl: "Projects/Pardarsh_web.jpeg",
      techStack: "HTML, CSS, JavaScript",
      projectLink: "",
      githubLink: "https://github.com/satyagyasingh/Pardarsh",
    ),
  ];

  final List<Project> uiUxProjects = [
    Project(
      title: "Spotify Clone",
      description: "UI/UX design for a mobile app using Figma.",
      imageUrl: "Projects/Spotify.png",
      techStack: "Figma",
      projectLink:
          "https://www.figma.com/design/5nyqNfaZKwHeag4fnVkNAG/Spotify-Clone?node-id=0-1&t=pP3iB08uAbh7X9RN-1",
      githubLink: "",
    ),
    Project(
      title: "JurishTech",
      description: "Designing a website with Adobe XD.",
      imageUrl: "Projects/JurishTech.png",
      techStack: "Figma",
      projectLink:
          "https://www.figma.com/design/ntlKIglity4QEXq09378Cx/JurishTech?node-id=0-1&t=0kSRAJqIyk44R4My-1",
      githubLink: "",
    ),
    Project(
      title: "BusTech",
      description: "A complete UI/UX redesign for a corporate website.",
      imageUrl: "Projects/BusTech.png",
      techStack: "Figma",
      projectLink:
          "https://www.figma.com/design/yLCukiY98FflTxZx0V5YLm/Bus?node-id=0-1&t=tEBYsLYViP2fTS1J-1",
      githubLink: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Projects",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Here are some of the projects I've worked on.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Section(
                sectionTitle: "App Development",
                projects: appProjects,
                isPortrait: true,
              ),
              const SizedBox(height: 40),
              Section(
                sectionTitle: "Web Development",
                projects: webProjects,
                isPortrait: false,
              ),
              const SizedBox(height: 40),
              Section(
                sectionTitle: "UI/UX Design",
                projects: uiUxProjects,
                isPortrait: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String sectionTitle;
  final List<Project> projects;
  final bool isPortrait;

  const Section({
    required this.sectionTitle,
    required this.projects,
    required this.isPortrait,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        // Display projects in a row
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: projects
              .map((project) =>
                  ProjectCard(project: project, isPortrait: isPortrait))
              .toList(),
        ),
      ],
    );
  }
}
