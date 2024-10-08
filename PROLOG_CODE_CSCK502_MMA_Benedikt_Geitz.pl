% Facts and Rules

% Symptom categories

/*The following complex terms, create the different symptoms classifictations,
given in the task description. The risk factors for age and existing diseases
are also created. */

common_symptoms(fever).
common_symptoms(dry_cough).
common_symptoms(tiredness).

less_common_symptoms(aches_and_pains).
less_common_symptoms(sore_throat).
less_common_symptoms(diarrhoea).
less_common_symptoms(conjunctivitis).
less_common_symptoms(headache).
less_common_symptoms(anosmia).
less_common_symptoms(hyposmia).
less_common_symptoms(runny_nose).

serious_symptoms(difficulty_breathing).
serious_symptoms(shortness_of_breath).
serious_symptoms(chest_pain).
serious_symptoms(chest_pressure).
serious_symptoms(loss_of_speech).
serious_symptoms(loss_of_movement).

% Risk factors
risk_factor(elderly).
risk_factor(pre_existing_condition).

/*The following functions are used to match the different sympton levels
and risk factors to the patient variable to make it easier to combine them
with the rules for the diagnosis. */

% Helper function for diagnosis
has_common_symptoms(Patient) :-
    symptom(Patient, Symptom),
    common_symptoms(Symptom).

has_less_common_symptoms(Patient) :-
    symptom(Patient, Symptom),
    less_common_symptoms(Symptom).

has_serious_symptoms(Patient) :-
    symptom(Patient, Symptom),
    serious_symptoms(Symptom).

is_elderly(Patient) :-
    age(Patient, Age),
    Age > 70.

has_pre_existing_condition(Patient) :-
    pre_existing_condition(Patient, Condition),
    risk_factor(pre_existing_condition).
    
/*The rules for diagnosis are used to combine the helper functions with a text
that for the output of the queries. It also classifies the infection possibility. */
    
% Diagnosing rules
possible_infection(Patient) :-
    has_common_symptoms(Patient),
    format('~w has possible infection based on common symptoms.~n', [Patient]).

possible_infection(Patient) :-
    has_less_common_symptoms(Patient),
    format('~w has possible infection based on less common symptoms.~n', [Patient]).

serious_infection(Patient) :-
    has_serious_symptoms(Patient),
    format('~w needs immediate medical attention based on serious symptoms.~n', [Patient]).

higher_risk_infection(Patient) :-
    is_elderly(Patient),
    format('~w is at higher risk due to age.~n', [Patient]).

higher_risk_infection(Patient) :-
    has_pre_existing_condition(Patient),
    format('~w is at higher risk due to pre-existing condition.~n', [Patient]).

/*The diagnosis logic combines the outputs and concepts of risk and symptom
classification and creates the additional case if none of the classifications/rules
are true. */

% Diagnosis logic
diagnose(Patient) :-
    serious_infection(Patient),
    higher_risk_infection(Patient).

diagnose(Patient) :-
    possible_infection(Patient),
    higher_risk_infection(Patient).

diagnose(Patient) :-
    possible_infection(Patient).

diagnose(Patient) :-
    format('~w does not show significant symptoms for virus infection.~n', [Patient]).

/*The following cases are created to test the expert system and different scenarios
regarding the patient's symptoms and age or pre-diseases.*/

% Patient 1 has fever and is elderly
symptom(patient1, fever).
age(patient1, 75).

% Patient 2 has sore throat, difficulty breathing, and chest pain
symptom(patient2, sore_throat).
symptom(patient2, difficulty_breathing).
symptom(patient2, chest_pain).
age(patient2, 40).

% Patient 3 has dry cough and is diabetic
symptom(patient3, dry_cough).
age(patient3, 55).
pre_existing_condition(patient3, diabetes).

% Patient 4 has conjunctivitis and runny nose
symptom(patient4, conjunctivitis).
symptom(patient4, runny_nose).
age(patient4, 30).

