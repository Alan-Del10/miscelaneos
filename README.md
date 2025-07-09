# miscelaneos

##Renombrar App ID
```
flutter pub run change_app_package_name:main com.alandelgado.miscelaneos
```
##Generar sha-256 para Android
```
cd android
./gradlew signingReport
```
##iOS Test
```
xcrun simctl openurl booted https://deeplinking-miscelaneos-webapp.firebaseapp.com/pokedex/1/
xcrun simctl openurl booted https://deeplinking-miscelaneos-webapp.firebaseapp.com/pokedex/
```
##Cambiar API Keys de Google Maps
```
https://console.cloud.google.com/google/maps-hosted/build?inv=1&invt=Ab193A&project=crafty-progress-465019-n7
```
##Crear credenciales de Google AdMob
```
https://developers.google.com/admob/flutter/quick-start#android
https://admob.google.com/
```