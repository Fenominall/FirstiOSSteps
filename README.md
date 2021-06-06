# FirstiOSSteps
This is a simple login app.

1. **First screen** - has two inputs "Login and Username" - restrictions:
  - The Username can be only English letters up to 20 symbols;
  - The Password can be only digits and specific symbols;
  - Has login button;
  - When credentials are entered an the button is pressed, the local storaqge should be checked for such credentials if successfull, the user can be logged in to teh second screen, otherwise the user should get a notification eeror about incorrect credentials.

2. **Second Screen**
  - The user should see a label whith his Username on top
  - Second screen has two buttons:
    - Update user`s Username and Password;
    - Log Out button

3. **Third Screen**
  - The user sees two inputs field with his username and password it has update button which is disabled until somehting is changed in the user`s credentials
  - By pressing button the data should be updated in the local storage and the user gets a success alert.
  - After the data is saved, the user is redirected two the second screen where he sees his updated **Username** label.
