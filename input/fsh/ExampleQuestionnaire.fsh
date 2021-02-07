Alias: $targetStructureMap = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-targetStructureMap


RuleSet: Question(context, linkId, text, type, repeats)
* {context}item[+].linkId = "{linkId}"
* {context}item[=].text = "{text}"
* {context}item[=].type = #{type}
* {context}item[=].repeats = {repeats}


Instance: case-reporting-questionnaire
InstanceOf: Questionnaire
Description: "Questionnaire for Case Reporting, containing/enabling the features described in this ImplementationGuide"
Title: "Case Reporting Questionnaire"


* contained[+] = vs-patientgender
* contained[+] = hiv-risk-population
* contained[+] = hiv-risk-behavior


* name = "CaseReportingQuestionnaire"
* title = "Case Reporting Questionnaire"
* version = "2020"
* status = #draft
* subjectType = #Patient
* language = #en
* status = #draft



/*
 To do: 
- Definition mapping 
- StructureMap mapping
*/

//* extension[0].valueCanonical = Canonical(HIVCaseReportMap)
//* extension[0].url = $targetStructureMap



* insert Question(,title, HIV Case Report, display, false)

* insert Question(,instructions, Please fill in this questionnaire monthly for each patient, display, false)

/*
* insert Question(,childHIVStatus, Child HIV Status, choice, false)
//* item[=].answerOption[+].valueCoding = #positive "Positive" 
//* item[=].answerOption[+].valueCoding = #negative "Negative" 
* item[=].answerOption[+].valueString = "Positive" 
* item[=].answerOption[+].valueString = "Negative" 
*/

* insert Question(,unit_name, Governing unit name, string, false)

* insert Question(,report-date, Date of Report, date, false)

* insert Question(,report-number, Report Number, string, false)


// This group belongs in a same "page" - see http://build.fhir.org/valueset-questionnaire-item-control.html
* insert Question(,patient-information, Patient Information, group, false)
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].extension.valueCodeableConcept =  #page


* insert Question(item[=].,unique_arv_number, Patient ARV identification number, string, false)
* item[=].item[=].prefix = "1"

* insert Question(item[=].,personal_info, Patient Personal information, group, false)
* item[=].item[=].prefix = "2"

* insert Question(item[=].,name,Full name,string, false)
* item[=].item[=].prefix = "3"

* insert Question(item[=].,ethnicity,Ethnicity,choice, false)
* item[=].item[=].prefix = "4"
* item[=].item[=].answerValueSet = Canonical(vs-ethnicity)


// Contained Expanded VS
* insert Question(item[=].,gender, Gender, choice, false)
* item[=].item[=].prefix = "5"
* item[=].item[=].answerValueSet = "#vs-patientgender"


* insert Question(item[=].,birth_year,Year of Birth, integer, false)
* item[=].item[=].prefix = "6"
// Define min and max value
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/minValue"
* item[=].extension.valueString = "1880"
* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/maxValue"
* item[=].extension.valueString = "2021"
// Optional, add a year as a regex
//* item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/regex"
//* item[=].extension.valueString = "([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00))"


* insert Question(item[=].,identification,Identification, group, false)
* item[=].item[=].prefix = "7"


* insert Question(item[=].item[=].,health_insurance_nr,Health insurance Number, string, false)
* item[=].item[=].item[=].prefix = "7.1"


* insert Question(item[=].item[=].,passport_nr,Passport Number, string, false)
* item[=].item[=].item[=].prefix = "7.2"

* insert Question(item[=].,residence,Residence, string, false)
* item[=].item[=].prefix = "8"

* insert Question(item[=].item[=].,permanent_residence,Permanent Residence, string, false)
* item[=].item[=].item[=].prefix = "8.1"

// FEATURE: RegEx           /////////////////////////////////////////////////////////////////////////////////////////////////
* insert Question(item[=].item[=].,postalcode, Postal Code, string, false)
* item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/StructureDefinition/regex"
* item[=].item[=].item[=].extension.valueString = "[A-Z][0-9][A-Z] [0-9][A-Z][0-9]"


* insert Question(item[=].item[=].,current_residence,Current Residence (if not same as permanent\), string, false)
* item[=].item[=].item[=].prefix = "8.2"

* insert Question(item[=].,occupation,Occupation, choice, false)
* item[=].item[=].prefix = "9"


* insert Question(,risk_factors,Risk Factors, group, false)

// FEATURE: Contained, Not (yet) expanded VS   /////////////////////////////////////////////////////////////////////////////////////////////////
* insert Question(item[=].,risk_population,Risk Population, choice, false)
* item[=].item[=].answerValueSet = Canonical(hiv-risk-population)

// FEATURE: External, Not (yet) expanded VS   /////////////////////////////////////////////////////////////////////////////////////////////////
* insert Question(item[=].,risk_behavior,Risk Behavior, choice, false)
* item[=].item[=].answerValueSet = Canonical(hiv-risk-behavior)

// FEATURE: External, expanded VS           /////////////////////////////////////////////////////////////////////////////////////////////////
* insert Question(item[=].,transmssion_route, Transmission Route, choice, false)
* item[=].item[=].answerValueSet = Canonical(hiv-transmission-route)


* insert Question(,hiv-diagnosis,HIV Diagnosis, group, false)
* item[=].prefix = "9"

* insert Question(item[=].,date-of-confirmation,Date of Confirmation, date, false)
* item[=].item[=].prefix = "11.1"

* insert Question(item[=].,confirming-lab,Confirming Lab, string, false)
* item[=].item[=].prefix = "11.2"

* insert Question(item[=].,date-of-specimen-collection,Date of Specimen Collection, date, false)
* item[=].item[=].prefix = "11.3"

* insert Question(item[=].,place-of-specimen-collection,Place of Specimen Collection, string, false)
* item[=].item[=].prefix = "11.4"


* insert Question(,hiv-recency-test,HIV Recency Test, group, false)
* item[=].prefix = "12"
* insert Question(item[=].,rapid-test,HIV Recency Rapid Test, group, false)
* item[=].item[=].prefix = "12.1"
* insert Question(item[=].item[=].,date-of-specimen-collection,Date of Specimen Collection, date, false)
* item[=].item[=].item[=].prefix = "12.1.1"
* insert Question(item[=].item[=].,place-of-specimen-collection,Place of Specimen Collection, string, false)
* item[=].item[=].item[=].prefix = "12.1.2"

// FEATURE: Explicit AnswerOption values   /////////////////////////////////////////////////////////////////////////////////////////////////
* insert Question(item[=].item[=].,rapid-test-result,Recency Rapid Test Result, choice, false)
* item[=].item[=].item[=].prefix = "12.1.3"
//* item[=].item[=].item[=].answerOption[+].valueCoding = #positive "Positive" 
//* item[=].item[=].item[=].answerOption[+].valueCoding = #negative "Negative" 
* item[=].item[=].item[=].answerOption[+].valueString = "Positive" 
* item[=].item[=].item[=].answerOption[+].valueString = "Negative" 


* insert Question(item[=].,vl-test,HIV Recency Rapid Test, group, false)
* item[=].item[=].prefix = "12.2"
* insert Question(item[=].item[=].,date-of-test-performance,Date of VL Recency test performance, date, false)
* item[=].item[=].item[=].prefix = "12.2.1"
* insert Question(item[=].item[=].,vl-test-result,VL Recency Test Result, choice, false)
* item[=].item[=].item[=].prefix = "12.2.2"




/*
* item[=].item[=].item[=].item[+].linkId = "hiv-recency-test.placeOfSpecimenCollection"
* item[=].item[=].item[=].item[=].text   = "Place of Specimen Collection"
* item[=].item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].item[=].prefix   = "12.1.3"

* item[=].item[=].item[=].item[+].linkId = "hiv-recency-test.testResult"
* item[=].item[=].item[=].item[=].text   = "Recency from rapid test - result"
* item[=].item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "HIVRecencyResults"
* item[=].item[=].item[=].item[=].prefix   = "12.1.4"



* item[=].item[=].item[+].linkId = "recency.vlTest"
* item[=].item[=].item[=].text   = "Rapid VL test"
* item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].prefix   = "12.2"

* item[=].item[=].item[=].item[+].linkId = "recency.dateOfTestPerformance"
* item[=].item[=].item[=].item[=].text   = "Date of rapid test performance"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "12.2.1"

* item[=].item[=].item[=].item[+].linkId = "recency.testResult"
* item[=].item[=].item[=].item[=].text   = "Recency from rapid test - result"
* item[=].item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "HIVRecencyResults"
* item[=].item[=].item[=].item[=].prefix   = "12.2.2"


* item[=].item[+].linkId = "cd4BeforeART"
* item[=].item[=].text   = "CD4 test before ART"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "13"


* item[=].item[=].item[+].linkId = "cd4BeforeART.dateOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Date of Specimen Collection for CD4 test before ART"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "13.1"

* item[=].item[=].item[+].linkId = "cd4BeforeART.dateOfTestPerformance"
* item[=].item[=].item[=].text   = "Date of CD4 test before ART performance"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "13.2"

* item[=].item[=].item[+].linkId = "cd4BeforeART.placeOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Place of Specimen Collection for CD4 test before ART"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "13.3"

* item[=].item[=].item[+].linkId = "cd4BeforeART.testResult"
* item[=].item[=].item[=].text   = "CD4 test before ART - result"
* item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].prefix   = "13.4"


* item[=].item[+].linkId = "cd4DuringART"
* item[=].item[=].text   = "CD4 test during ART"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "14"

* item[=].item[=].item[+].linkId = "cd4DuringART.dateOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Date of Specimen Collection for CD4 test during ART"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "14.1"

* item[=].item[=].item[+].linkId = "cd4DuringART.dateOfTestPerformance"
* item[=].item[=].item[=].text   = "Date of CD4 test during ART performance"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "14.2"

* item[=].item[=].item[+].linkId = "cd4DuringART.placeOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Place of Specimen Collection for CD4 test during ART"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "14.3"

* item[=].item[=].item[+].linkId = "cd4DuringART.testResult"
* item[=].item[=].item[=].text   = "CD4 test during ART - result"
* item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].prefix   = "14.4"


* item[=].item[+].linkId = "vl4DuringART"
* item[=].item[=].text   = "Viral Load test during ART"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "15"

* item[=].item[=].item[+].linkId = "vl4DuringART.dateOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Date of Specimen Collection for VL test during ART"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "15.1"

* item[=].item[=].item[+].linkId = "vl4DuringART.dateOfTestPerformance"
* item[=].item[=].item[=].text   = "Date of VL test during ART performance"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "15.2"

* item[=].item[=].item[+].linkId = "vl4DuringART.placeOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Place of Specimen Collection for VL test during ART"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "15.3"

* item[=].item[=].item[+].linkId = "vl4DuringART.testResult"
* item[=].item[=].item[=].text   = "VL test during ART - result"
* item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].prefix   = "15.4"




* item[=].item[+].linkId = "drugResistanceTest"
* item[=].item[=].text   = "Drug Resistance test"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "15"

* item[=].item[=].item[+].linkId = "drugResistanceTest.dateOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Date of Specimen Collection for Drug Resistance test"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "15.5"

* item[=].item[=].item[+].linkId = "drugResistanceTest.dateOfTestPerformance"
* item[=].item[=].item[=].text   = "Date of Drug Resistance test"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "15.6"

* item[=].item[=].item[+].linkId = "drugResistanceTest.placeOfSpecimenCollection"
* item[=].item[=].item[=].text   = "Place of Specimen Collection for Drug Resistance test"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "15.7"

* item[=].item[=].item[+].linkId = "drugResistanceTest.testResult"
* item[=].item[=].item[=].text   = "Drug Resistance test result"
* item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].prefix   = "15.8"


* item[=].item[+].linkId = "arvTreatment"
* item[=].item[=].text   = "ARV Treatment"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "16"

* item[=].item[=].item[+].linkId = "arvTreatment.treatmentHistory"
* item[=].item[=].item[=].text   = "ARV Treatment history"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "16.1"

* item[=].item[=].item[+].linkId = "arvTreatment.dateOfTreatmentStart"
* item[=].item[=].item[=].text   = "Date of treatment start"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "16.1"

* item[=].item[=].item[+].linkId = "arvTreatment.dateOfTreatmentStop"
* item[=].item[=].item[=].text   = "Date of treatment stop"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "16.3"

* item[=].item[=].item[+].linkId = "arvTreatment.placeOfInitiation"
* item[=].item[=].item[=].text   = "Place of ARV treatment initiation"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "16.4"

* item[=].item[=].item[+].linkId = "arvTreatment.dateOfLossToFollowUp"
* item[=].item[=].item[=].text   = "Date of loss to follow up"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "16.5"

* item[=].item[=].item[+].linkId = "arvTreatment.dateOfTransferredOut"
* item[=].item[=].item[=].text   = "Date ARV treatment transferred out"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "16.6"

* item[=].item[=].item[+].linkId = "arvTreatment.placeTransferredOut"
* item[=].item[=].item[=].text   = "Place ARV treatment transferred out"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "16.7"

* item[=].item[=].item[+].linkId = "arvTreatment.regimens"
* item[=].item[=].item[=].text   = "ARV treatment regimens"
* item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].prefix   = "16.8"

* item[=].item[=].item[=].item[+].linkId = "regimen.date1stLineStarted"
* item[=].item[=].item[=].item[=].text   = "Date 1st ARV regimen started"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "16.8.1"

* item[=].item[=].item[=].item[+].linkId = "arvTreatment.date2ndLineStarted"
* item[=].item[=].item[=].item[=].text   = "Date 3rd ARV regimen started"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "16.8.2"

* item[=].item[=].item[=].item[+].linkId = "arvTreatment.date3rdLineStarted"
* item[=].item[=].item[=].item[=].text   = "Date 3rd ARV regimen started"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "16.8.3"


* item[=].item[+].linkId = "comorbidities"
* item[=].item[=].text   = "Comorbidities"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "17"

* item[=].item[=].item[+].linkId = "tuberculosis"
* item[=].item[=].item[=].text   = "Tuberculosis"
* item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].prefix   = "17.1"

* item[=].item[=].item[=].item[+].linkId = "TPT"
* item[=].item[=].item[=].item[=].text   = "TPT"
* item[=].item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].item[=].prefix   = "17.1.1"

* item[=].item[=].item[=].item[=].item[+].linkId = "tpt.dateStarted"
* item[=].item[=].item[=].item[=].item[=].text   = "Date TPT started"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.1.1"

* item[=].item[=].item[=].item[=].item[+].linkId = "tpt.dateCompleted"
* item[=].item[=].item[=].item[=].item[=].text   = "Date TPT completed"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.1.2"

* item[=].item[=].item[=].item[=].item[+].linkId = "tpt.placeProvided"
* item[=].item[=].item[=].item[=].item[=].text   = "Place TPT provided"
* item[=].item[=].item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.1.3"

* item[=].item[=].item[=].item[+].linkId = "tbDiagnosisDate"
* item[=].item[=].item[=].item[=].text   = "TB Diagnosis Date"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "17.1.2"


* item[=].item[=].item[=].item[+].linkId = "tbTreatment"
* item[=].item[=].item[=].item[=].text   = "TB Treatment"
* item[=].item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].item[=].prefix   = "17.1.3"

* item[=].item[=].item[=].item[=].item[+].linkId = "tbTreatment.dateStarted"
* item[=].item[=].item[=].item[=].item[=].text   = "Date TB Treatment started"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.3.1"

* item[=].item[=].item[=].item[=].item[+].linkId = "tbTreatment.dateCompleted"
* item[=].item[=].item[=].item[=].item[=].text   = "Date TB Treatment completed"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.3.2"

* item[=].item[=].item[=].item[=].item[+].linkId = "tbTreatment.placeProvided"
* item[=].item[=].item[=].item[=].item[=].text   = "Place TB Treatment provided"
* item[=].item[=].item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.3.3"



* item[=].item[=].item[+].linkId = "hbv_hcv"
* item[=].item[=].item[=].text   = "HBV and HCV"
* item[=].item[=].item[=].type   = #group

* item[=].item[=].item[=].item[+].linkId = "hbv"
* item[=].item[=].item[=].item[=].text   = "HBV"
* item[=].item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[=].item[+].linkId = "hbv.diagnosisDate"
* item[=].item[=].item[=].item[=].item[=].text   = "Date of HBV diagnosis"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[=].item[+].linkId = "hbv.treatmentStartDate"
* item[=].item[=].item[=].item[=].item[=].text   = "Date of HBV treatment start"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[=].item[+].linkId = "hbv.treatmentEndDate"
* item[=].item[=].item[=].item[=].item[=].text   = "Date HBV treatment completed"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[=].item[+].linkId = "hbv.placeProvided"
* item[=].item[=].item[=].item[=].item[=].text   = "Place HBV treatment provided"
* item[=].item[=].item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[+].linkId = "hcv"
* item[=].item[=].item[=].item[=].text   = "HCV"
* item[=].item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].item[=].prefix   = "17.1.4"

* item[=].item[=].item[=].item[=].item[+].linkId = "hcv.diagnosisDate"
* item[=].item[=].item[=].item[=].item[=].text   = "Date of HBV diagnosis"
* item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"

// * item[=].item[=].item[=].item[=].item[+].linkId = "hcv.treatmentStartDate"
// * item[=].item[=].item[=].item[=].item[=].text   = "Date of HBV treatment start"
// * item[=].item[=].item[=].item[=].item[=].type   = #date
// * item[=].item[=].item[=].item[=].item[+].linkId = "hcv.treatmentEndDate"
// * item[=].item[=].item[=].item[=].item[=].text   = "Date HBV treatment completed"
// * item[=].item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].item[+].linkId = "hcv.placeProvided"
* item[=].item[=].item[=].item[=].item[=].text   = "Place HBV treatment provided"
* item[=].item[=].item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].item[=].item[=].prefix   = "17.1.4"



* item[=].item[+].linkId = "pregnancies"
* item[=].item[=].text   = "ARV Treatment"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "datePregnancyReported"
* item[=].item[=].item[=].text   = "Date pregnancy reported"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "placePregnancyReported"
* item[=].item[=].item[=].text   = "Place pregnancy reported"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "childDeliveryDate"
* item[=].item[=].item[=].text   = "Reported child delivery date"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "childDeliveryPlace"
* item[=].item[=].item[=].text   = "Reported child delivery place"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "pregnancyOutcomes"
* item[=].item[=].item[=].text   = "Pregnancy Outcomes"
* item[=].item[=].item[=].type   = #group
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "pregnancyOutcomeCode"
* item[=].item[=].item[=].item[=].text   = "Pregnancy Outcome code"
* item[=].item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "#PregnancyOutcomeCodes"
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "childDateOfBirth"
* item[=].item[=].item[=].item[=].text   = "Date of child birth"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "gestationAtDelivery"
* item[=].item[=].item[=].item[=].text   = "Gestational age at delivery (weeks)"
* item[=].item[=].item[=].item[=].type   = #decimal
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "birthWeight"
* item[=].item[=].item[=].item[=].text   = "Weight at birth (kg)"
* item[=].item[=].item[=].item[=].type   = #decimal
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "birtDefects"
* item[=].item[=].item[=].item[=].text   = "Birth defects"
* item[=].item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "#BirthDefects"
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "hivStatus"
* item[=].item[=].item[=].item[=].text   = "HIV status"
* item[=].item[=].item[=].item[=].type   = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "#ChildHIVStatus"
* item[=].item[=].item[=].item[=].prefix   = "19"


* item[=].item[=].item[=].item[+].linkId = "childHIVDiagnosisDate"
* item[=].item[=].item[=].item[=].text   = "HIV diagnosis date"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[=].item[+].linkId = "childARTStartDate"
* item[=].item[=].item[=].item[=].text   = "ART start date"
* item[=].item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].item[=].prefix   = "19"






* item[=].item[+].linkId = "death"
* item[=].item[=].text   = "Patient death"
* item[=].item[=].type   = #group
* item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "dateOfDeath"
* item[=].item[=].item[=].text   = "Date of death"
* item[=].item[=].item[=].type   = #date
* item[=].item[=].item[=].prefix   = "19"

* item[=].item[=].item[+].linkId = "causeOfDeath"
* item[=].item[=].item[=].text   = "Cause of death"
* item[=].item[=].item[=].type   = #string
* item[=].item[=].item[=].prefix   = "19"
*/