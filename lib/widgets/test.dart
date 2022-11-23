import 'package:flutter/cupertino.dart';

import 'globals.dart' as globals;

List GA(var Title) {
  if (Title == "Physical") {
    //
    print("Physical Initialise");

    globals.GeneratedAdvices = globals.Advices["Physical"];
    //
  } else if (Title == "Mental") {
    //
    print("Mental Initialise");
    globals.GeneratedAdvices = globals.Advices["Mental"];
    globals.GeneratedAdvices.addAll(globals.Advices["Isolation"]);
    globals.GeneratedAdvices.addAll(globals.Advices["Depression"]);
    //
  } else if (Title == "Harassment") {
    //
    globals.GeneratedAdvices = globals.Advices["Helpline"];
  } else if (Title == "Menstrual") {
    //
    print("Menstrual Called");
    globals.GeneratedAdvices = globals.Advices["Menstrual"];
  }
  return globals.GeneratedAdvices;
}
