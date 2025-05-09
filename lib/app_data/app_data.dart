class AppData {
  static final List<String> days = [
    'MON', 'TUE','WED', 'THU', 'FRI','SAT', 'SUN'
  ];

  static String getDayByID(int id){
    switch(id){
      case 0:
        return 'MON';
      case 1:
        return 'TUE';
      case 2:
        return 'WED';
      case 3:
        return 'THU';
      case 4:
        return 'FRI';
      case 5:
        return 'SAT';
      case 6:
        return 'SUN';
      default:
        return 'MON';
    }
  }
/*
  static List<AccessRequestModel> get getRequestAccessList {
    return [
      AccessRequestModel(id: 1, icon: AppIcons.icPool, title: "Pool"),
      AccessRequestModel(id: 2, icon: AppIcons.icGame, title: "Game"),
      AccessRequestModel(id: 3, icon: AppIcons.icGym, title: "Gym"),
    ];
  }

  static List<EmergencyContactModel> get emergencyContacts {
    return [
      EmergencyContactModel(id: 1, name: "Isela Trujillo", phoneNumber: "+92 3072215500"),
      EmergencyContactModel(id: 1, name: "Sheraz Ali", phoneNumber: "+92 3072215500"),

    ];
  }

 */
}