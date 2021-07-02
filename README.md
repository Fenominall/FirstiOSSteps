# FirstiOSSteps
This is a simple Login app.

1. **First screen** - has two inputs "Login and Username" - restrictions:
  - The Username can be only English letters up to 20 symbols;
  - The Password can be only digits and specific symbols;
  - Has login button;
  - When credentials are entered and the button is pressed, the local storaqge should be checked if the inputed text matching the requirements, the user can be logged in and trasfered to second screen, otherwise the user should get a notification error about incorrect credentials.

2. **Second Screen**
  - The user should see a label whith his Username on top
  - Second screen has two buttons:
    - Update user`s Username and Password;
      - By pressing the "Update Info Button" the user is pushed to the ThirdViewController where he can update his data.
    - Log Out button - ogs the user out and pushes him to the FirstViewController

3. **Third Screen**
  - The user sees two inputs fields with his "Username" and "Password" the view has "Update button", which is disabled until somehting is changed in the user`s credentials UiTextFields
  - By pressing button the data should be updated in the local storage and the user gets a success alert.
  - After the data is saved, the user is redirected two the second screen where he sees his updated **Username** label.
