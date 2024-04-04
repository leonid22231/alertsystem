// ignore_for_file: file_names

class GlobalsSettingsEntity{
  int nType;
  int minMag;
  int mSystem;
  int cont;
  int timeR;
  bool allNotify;
  int countryId;

  GlobalsSettingsEntity({
    required this.nType,
    required this.minMag,
    required this.mSystem,
    required this.cont,
    required this.timeR,
    required this.allNotify,
    required this.countryId
});

  @override
  String toString() {
    return 'GlobalsSettingsEntity{nType: $nType, minMag: $minMag, mSystem: $mSystem, cont: $cont, timeR: $timeR, allNotify: $allNotify, countryId: $countryId}';
  }
}