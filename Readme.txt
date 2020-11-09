Ege Cavusoglu (463866) Lab 4

Creative Portion Points Distribution
- Google Sign In (15 Pts.)
- Maintaining Login Status across app launches. (5 Pts.)
- Firebase Realtime Database (10 pts.)

What?
1. I implemented a industry standard auth library - Google Sign In - that will log them in to the Cameo Firebase project. Leveraging the Firebase Realtime Database I synced all the app activity of the users with database and saved this to their account which makes it accessible from all devices.
 
How? 
2. I used Firebase iOS SDK and implemented the Google Sign in conforming to the delegates in a designated Signin View Controller. Created a singleton User class to manage auth state and control user operations and utilized User Defaults to persist the auth state within app launches. In this singleton class I implemented class methods that allow to CRUD (create, read, update and delete) operations using the Firebase Document database data structuring methods. Then used Firebase methods to subscribe to the database to us its realtime data sync faeture which allowed me to reload table data when the list has changed.

Why?
3. It is important in such apps to persist data across devices and logins to make the app useful. This is because watching movies is a life long activity and people always like to remember films that they liked or want to watch. Changing a device or accessing data across multiple platforms is vital and is only made possible by the sign in, auth and the data storage mechanisms I implemented.


