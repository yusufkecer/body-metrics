enum Pages {
  avatarPage,
  createProfilePage,
  genderPage,
  heightPage,
  weightPage,
}

extension StringToPages on String {
  Pages toPages() {
    switch (this) {
      case 'avatarPage':
        return Pages.avatarPage;
      case 'createProfilePage':
        return Pages.createProfilePage;
      case 'genderPage':
        return Pages.genderPage;
      case 'heightPage':
        return Pages.heightPage;
      case 'weightPage':
        return Pages.weightPage;
      default:
        return Pages.avatarPage;
    }
  }
}
