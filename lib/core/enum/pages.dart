enum Pages {
  avatarPage,
  userGeneralInfo,
  genderPage,
  heightPage,
  weightPage,
  homePage,
  onboardPage,
}

extension StringToPages on String {
  Pages toPages() {
    switch (this) {
      case 'avatarPage':
        return Pages.avatarPage;
      case 'createProfilePage':
        return Pages.userGeneralInfo;
      case 'genderPage':
        return Pages.genderPage;
      case 'heightPage':
        return Pages.heightPage;
      case 'weightPage':
        return Pages.weightPage;
      case 'homePage':
        return Pages.homePage;
      case 'onboardPage':
        return Pages.onboardPage;
      default:
        return Pages.avatarPage;
    }
  }
}
