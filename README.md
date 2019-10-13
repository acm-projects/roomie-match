# roomie-match
Mobile app for matching roommates based on questions about habits, budget, life situation, and more

matching-screens TODO:

* Add sample users to Firestore that have all of the necessary fields as laid out in the Profile class (profile.dart)

* Test findSearches() method

* Update distance check to :
if distance <= searchingUserRadius AND distance <= potentialMatchRadius then
  match()
end if

* Automatically add new users to Firestore using their UUID as the Firestore ID

* Add age range directly to query (if there's time)

* Prevent matching with the same person more than once (if there's time)
