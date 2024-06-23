# HealthForAll pasi de compilare si rulare

## Descriere

HealthForAll este o aplicatie mobila, care ofera pacientilor posibilitatea de alegere
si programare la consultatie catre medicul dorit, propus dintr-o lista de medici specialisti
disponibili si inregistrati, din toata tara. 


## Repository

Codul sursa complet al proiectului este disponibil la urmatoarea adresa:
[Repository GitHub](https://github.com/IulianScoropad/healthforall)

## Pasi de Configurare

1. **Instalam si configuram Android Studio**  
   Urmariti pasii de la adresa urmatoare: [Instalare Android Studio](https://developer.android.com/studio/install#windows). 
   Eu am lucrat pe versiunea de Windows, dar poate fi instalat pe sistemul de operare pe care il aveti.

2. **Instalam pachetul de servicii Git**  
   [Git pentru Windows](https://gitforwindows.org/)  
   GitHub Desktop este necesar pentru a face commit-uri direct din mediul de programare. De asemenea, este un tool necesar framework-ului Flutter.

3. **Instalam SDK de Flutter**  
   [Instalare Flutter SDK](https://docs.flutter.dev/get-started/install/windows/mobile?tab=physical)  
   Eu l-am configurat pentru utilizarea in Android Studio. Pentru aceasta, vom instala plug-inul Flutter: [Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter).

## Verificare Instalare 

**Dupa ce am facut toti pasii de mai sus, in PowerShell rulam urmatoarea comanda:**

```powershell
PS C:> flutter doctor
```

**Daca am instalat tot corect o sa primim urmatorul text:** 

```powershell
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.22.1, on Microsoft Windows 11 [Version 10.0.22621.3155], locale en)
[✓] Windows version (Installed version of Windows is version 10 or higher)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.5)
[!] Chrome - develop for the web
[!] Visual Studio - develop Windows apps
[✓] Android Studio (version 2023.3)
[✓] VS Code (version 1.89)
[✓] Connected device (1 available)
[✓] Network resources


! Doctor found issues in 2 categories.
```

**In cazul in care am primit eroare rulam urmatoarea comanda**

```powershell
PS C:> flutter doctor -v
```

**Analizam ce mai avem de instalat, instalam dupa care mai rulam din nou comanda** 

```powershell
PS C:> flutter doctor
```

## Pasi de Compilare

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
Eu am testat tot pe dispozitivul meu fizic Xiaomi Redmi Note 8T ce ruleaza pe Android 11.
    - In Android Studio, apasa butonul de rulare (Run) sau foloseste comanda:
        ```sh
        flutter run
        ```
