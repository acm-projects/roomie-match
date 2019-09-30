/*
The Allergies class allows for the organization of allergy information as given by the user
in the profile questionnaire
*/
import "allergy_trigger.dart";
import "allergy_severity.dart";

class Allergy {
  String name;
  AllergyTrigger allergyTrigger;
  AllergySeverity allergySeverity;

  Allergy(this.name, this.allergyTrigger, this.allergySeverity);
}