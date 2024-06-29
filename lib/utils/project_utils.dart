class ProjectUtils {
  final String image;
  final String title;
  final String subtitle;
  final String? androidLink;
  final String? githubLink;
  final String? iosLink;
  final String? webLink;

  ProjectUtils(
      {required this.image,
      required this.title,
      required this.subtitle,
      this.androidLink,
      this.iosLink,
      required this.webLink,
      required this.githubLink});
}

// ###############
// HOBBY PROJECTS
List<ProjectUtils> hobbyProjectUtils = [
  ProjectUtils(
      image: 'assets/projects/01.png',
      title: 'Photo Gallery',
      subtitle: 'An app for Shows different type of photos with Captions',
      webLink: 'https://photogalleryprv.netlify.app',
      githubLink: 'https://github.com/ahmadhabibshovo/PhotoGallery'),
  ProjectUtils(
      image: 'assets/projects/02.png',
      title: 'Flutter Meals',
      subtitle: 'An app for Shows Meals and Meals items',
      webLink: 'https://flutter-meal.netlify.app/',
      githubLink: 'https://github.com/ahmadhabibshovo/Flutter_Meals'),
  ProjectUtils(
      image: 'assets/projects/03.png',
      title: 'BMI Calculator',
      subtitle: 'An app for Calculate BMI',
      webLink: 'https://bmicalculatorprv.netlify.app/',
      githubLink: 'https://github.com/ahmadhabibshovo/bmi_calculator'),
  ProjectUtils(
      image: 'assets/projects/04.png',
      title: 'Expense Tracker',
      subtitle: 'An app That you can track expense with a expense chart',
      webLink: 'https://prvexpensetracker.netlify.app/',
      githubLink: 'https://github.com/ahmadhabibshovo/expense_tracker'),
  ProjectUtils(
      image: 'assets/projects/05.png',
      title: 'Todo App',
      subtitle: 'An app That you can track Todo List and which Task Done',
      webLink: 'https://prvtodoapp.netlify.app/',
      githubLink: 'https://github.com/ahmadhabibshovo/todo_app'),
  ProjectUtils(
      image: 'assets/projects/06.png',
      title: 'Calculator',
      subtitle: 'A Calculator App ',
      webLink: 'https://prevcalculator.netlify.app/',
      githubLink: 'https://github.com/ahmadhabibshovo/caluator'),
];

// ###############
// WORK PROJECTS
// List<ProjectUtils> workProjectUtils = [
//   ProjectUtils(
//     image: 'assets/projects/w01.png',
//     title: 'English Brain Craft',
//     subtitle:
//         'This is an English learning app for students to learn English through various methods.',
//     androidLink:
//         'https://play.google.com/store/apps/details?id=kr.co.evolcano.donotstudy',
//     iosLink:
//         "https://apps.apple.com/kr/app/%EC%98%81%EC%96%B4%EB%A8%B8%EB%A6%AC-%EA%B3%B5%EC%9E%91%EC%86%8C/id1507102714",
//   ),
//   ProjectUtils(
//     image: 'assets/projects/w02.png',
//     title: 'Online Shop Web App',
//     subtitle:
//         'This is a responsive online shop web application for car engine oil.',
//     webLink: 'https://www.elo.best',
//   ),
//   ProjectUtils(
//     image: 'assets/projects/w03.jpeg',
//     title: 'Advertisement Management System',
//     subtitle:
//         'This is an Advertisement Management System to buy, sell, and manage advertisement.',
//     webLink: 'https://www.externally.unavailable.project',
//   ),
// ];
