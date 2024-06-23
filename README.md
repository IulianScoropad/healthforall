# HealthForAll pași de compilare și rulare

## Descriere

HealthForAll este o aplicație mobilă, care oferă pacienților posibilitatea de alegere
și programare la consultație către medicul dorit, propus dintr-o listă de medici specialiști
disponibili și înregistrați, din toată țara. 


## Repository

Codul sursă complet al proiectului este disponibil la următoarea adresa:
[Repository GitHub](https://github.com/IulianScoropad/healthforall)

## Pași de Configurare

1. **Instalăm și configurăm Android Studio**  
   Urmăriți pașii de la adresa următoare: [Instalare Android Studio](https://developer.android.com/studio/install#windows). 
   Eu am lucrat pe versiunea de Windows, dar poate fi instalat pe sistemul de operare pe care îl aveți.

2. **Instalăm pachetul de servicii Git**  
   [Git pentru Windows](https://gitforwindows.org/)  
   GitHub Desktop este necesar pentru a face commit-uri direct din mediul de programare. De asemenea, este un tool necesar framework-ului Flutter.

3. **Instalăm SDK de Flutter**  
   [Instalare Flutter SDK](https://docs.flutter.dev/get-started/install/windows/mobile?tab=physical)  
   Eu l-am configurat pentru utilizarea în Android Studio. Pentru aceasta, vom instala plug-inul Flutter: [Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter).

## Verificare Instalare 

**După ce am făcut toți pașii de mai sus, în PowerShell rulăm următoarea comandă:**

```sh
 flutter doctor
```

**Dacă am instalat tot corect o să primim următorul text:** 

```sh
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.22.1, on Microsoft Windows 11 [Version 10.0.22621.3155], locale en)
[✓] Windows version (Installed version of Windows îs version 10 or higher)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.5)
[!] Chrome - develop for the web
[!] Visual Studio - develop Windows apps
[✓] Android Studio (version 2023.3)
[✓] VS Code (version 1.89)
[✓] Connected device (1 available)
[✓] Network resources


! Doctor found issues în 2 categories.
```

**În cazul în care am primit eroare rulăm următoarea comandă**

```sh
 flutter doctor -v
```

**Analizăm ce mai avem de instalat, instalăm după care mai rulăm din nou comanda** 

```sh
 flutter doctor
```

## Pași de Compilare

1. **Clonează repository-ul:**
    ```sh
    git clone https://github.com/IulianScoropad/healthforall.git
    cd healthforall
    ```

2. **Deschide proiectul în Android Studio:**
    - Deschide Android Studio și selectează `Open an existing project`, apoi navighează la directorul proiectului clonat.

3. **Instalează dependințele:**
    ```sh
    flutter pub get
    ```
4. **Rulează aplicația:**
    - Conectează un [dispozitiv Android](https://developer.android.com/studio/debug/dev-options)  sau lansează un [Emulator](https://developer.android.com/studio/run/managing-avds).
Eu am testat tot pe dispozitivul meu fizic Xiaomi Redmi Note 8T ce rulează pe Android 11.
    - În Android Studio, apasă butonul de rulare (Run) sau folosește comanda:
        ```sh
        flutter run
        ```


## Instalare Dispozitiv

În cazul în care doriți să instalați aplicația direct pe dispozitivele persoanle, o puteți face doar dacă dispuneți de un dispozitiv Android cu o versiunea mai mare de 9, descărcând [APK-ul](https://uptro29158-my.sharepoint.com/personal/iulian_scoropad_student_upt_ro/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Fiulian%5Fscoropad%5Fstudent%5Fupt%5Fro%2FDocuments%2FLicenta%2FReadme%26APK&ga=1)

În cazul în care întâmpinați dificultăți în instalarea aplicației [aici](https://www.digitalcitizen.ro/cum-instalezi-aplicatii-pe-dispozitive-cu-android-folosind-fisiere-apk/#ftoc-cum-instalezi-un-apk-pe-android) aveți informații despre cum puteți permite instalarea aplicațiilor din surese necunocute.
