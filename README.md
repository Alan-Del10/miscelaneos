# miscelaneos

##Renombrar App ID
````
flutter pub run change_app_package_name:main com.alandelgado.miscelaneos
```
Generar sha-256 para Android
````
cd android
./gradlew signingReport
```
## iOS Test
```
xcrun simctl openurl booted https://deeplinking-miscelaneos-webapp.firebaseapp.com/pokedex/1/
```