class ProjectUtils {
  final String image;
  final String title;
  final String subtitle;
  final String? androidLink;
  final String? githubLink;
  final String? iosLink;
  final String? webLink;

  ProjectUtils({
    required this.image,
    required this.title,
    required this.subtitle,
    this.androidLink,
    this.iosLink,
    this.webLink,
    this.githubLink,
  });
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
List<ProjectUtils> workProjectUtils = [
  ProjectUtils(
    image: 'assets/projects/rv_way.png',
    title: 'Rv way',
    subtitle:
        'App featuring Mapbox routing, IAP subscription, Google AdMob, and AI chatting integration.',
    androidLink: 'https://play.google.com/store/apps/details?id=com.rvway.app',
    iosLink: 'https://apps.apple.com/mo/app/rvway/id6759445243',
  ),
  ProjectUtils(
    image: 'assets/projects/moto_master.png',
    title: 'Moto Master App',
    subtitle:
        'Mobile app featuring IAP subscription, Mapbox and Grasshopper map routing engine for custom motorcycle routes.',
    androidLink: 'https://play.google.com/store/apps/details?id=com.moto.master',
    iosLink: 'https://apps.apple.com/us/app/moto-master/id6755039384',
  ),
  ProjectUtils(
    image: 'assets/projects/timbernet.png',
    title: 'TimberNet',
    subtitle:
        'Forestry management app featuring offline Mapbox map downloading, and online/offline SQLite sync.',
    androidLink:
        'https://play.google.com/store/apps/details?id=de.kazmos.timbernet&pcampaignid=web_share',
    iosLink: 'https://apps.apple.com/us/app/timbernet-mobile/id6749359970',
  ),
  ProjectUtils(
    image: 'assets/projects/rovascore.png',
    title: 'Rovascore live scores',
    subtitle:
        'Live sports scores and news application with real-time match events and Google AdMob integration.',
    androidLink:
        'https://play.google.com/store/apps/details?id=com.rovascore.app&pcampaignid=web_share',
    iosLink: 'https://apps.apple.com/us/app/rovascore-live-scores-news/id6756863993',
  ),
  ProjectUtils(
    image: 'assets/projects/sell_your_strips.png',
    title: 'Sell Your Strips',
    subtitle:
        'E-commerce solution built with WordPress WooCommerce REST APIs and custom state management.',
    androidLink:
        'https://play.google.com/store/apps/details?id=com.sellyourstripsusa.app&pcampaignid=web_share',
    iosLink:
        'https://apps.apple.com/us/app/sell-your-strips/id6751053534?platform=iphone',
  ),
  ProjectUtils(
    image: 'assets/projects/frapp.png',
    title: 'Frapp',
    subtitle:
        'Community social network app for creators & students to showcase talent, live stream, and access workshops.',
    iosLink: 'https://apps.apple.com/us/app/frapp-discover-connect-grow/id6759274038',
  ),
  ProjectUtils(
    image: 'assets/projects/lockzi.png',
    title: 'Lockzi',
    subtitle:
        'Business platform empowering content creators to securely share and sell digital media directly to their audience.',
    androidLink: 'https://play.google.com/store/apps/details?id=ac.lockzi.app&pcampaignid=web_share',
    iosLink: 'https://apps.apple.com/us/app/lockzi/id6768182674',
  ),
  ProjectUtils(
    image: 'assets/projects/drivetime.png',
    title: 'DriveTime',
    subtitle:
        'Specialized tracking application focused on real-time driving metrics and user engagement.',
    androidLink: 'https://play.google.com/store/apps/details?id=io.drivetime.app&pcampaignid=web_share',
    iosLink: 'https://apps.apple.com/us/app/developer/ibrahim-cheikh/id1895712407',
  ),
  ProjectUtils(
    image: 'assets/projects/masadari.png',
    title: 'Masadari',
    subtitle:
        'Educational marketplace (LMS) for teachers and students to buy/sell digital resources with PayTabs integration.',
    androidLink: 'https://play.google.com/store/apps/details?id=com.masadrimobile.app&pcampaignid=web_share',
    iosLink: 'https://apps.apple.com/us/app/masadri/id6741678339',
  ),
];
