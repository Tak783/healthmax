# HealthMax.AI – README

* Simple health metrics dashboard app to display data from user input and Apple Health
* Connects to OpenAI to give the user tips on how to maximise their health
* Has an Apple Watch Companion app  "Max Calorie Burner"

## 🚀 Highlights

* Backend-driven Quiz Feature: just pass in JSON and a dynamic quiz is generated with data collection, upsell, and device permissions  
* Platform agnostic components, i.e.` QuizFeature` & `UserBiometricsFeature`, supported by UI Layer packages, i.e. `QuizFeatureUI `
* Layered modular package structure designed for maximum reusability  
* Basic design system supporting Fonts, Layout, and Gradients  
* Haptic Feedback on button taps, Elegant UI  
* SwiftUI Coordinator and Router for App Navigation  
* Onboarding flow designed and implemented with strategies to maximise Funnel Conversion, Data Collection & User retention  
* Protocol-oriented approach to building, services, view models and test specs to maximise reusability, flexibility and testability
* New in V0.2.0: MaxPlan View: Healthmax now has a backend that returns AI-generated insights from Static and dynamic (HealthKit) data using OpenAI
* ⭐️ New in V0.2.1: Apple Watch companion app "Max Calorie Burner" helps users maximise their calorie burn with tips based on their calories burned for the day, sourced from HealthKit

<p float="left">
<img src="https://github.com/user-attachments/assets/b12f72ab-d058-4188-8f98-1cc25577ca4a" width="150" align="left">
<img src="https://github.com/user-attachments/assets/12e38bb7-8072-4cb9-819a-5a945dfdc152" width="150" align="left">
<img src="https://github.com/user-attachments/assets/8bb88640-019b-426f-8970-eb2c3aae1dcb" width="150" align="left">
<img src="https://github.com/user-attachments/assets/cde1f064-6d1e-407b-a4af-888e859066de" width="150" align="left">
</p>
<br clear="all" />
<br/>
<p float="left">
<img src="https://github.com/user-attachments/assets/39441723-55ec-4082-ab23-a592037a8282" width="100" align="left">
<img src="https://github.com/user-attachments/assets/a625c6fc-b9e2-4a4a-9a87-f932ffe862ec" width="100" align="left">
<img src="https://github.com/user-attachments/assets/9898f420-5ef3-4b58-9227-b6194bf09805" width="100" align="left">
<img src="https://github.com/user-attachments/assets/2103daef-df28-4339-bcae-3bc8298d6d84" width="100" align="left">
<img src="https://github.com/user-attachments/assets/92fb220c-d50f-4a4e-9a68-df8b9d1dabf3" width="100" align="left">
<img src="https://github.com/user-attachments/assets/818c97dd-d4e3-42d8-8d65-9d5fd7a374d6" width="100" align="left">
</p>
<br clear="all" />

## 📱 For the Best User Experience
1. Add Codesigning using your Apple Developer account in the XCode Project Settings
2. Run Xcode and install it on the device
3. 🚨 For full experience - Accept notifications in totality (close the app and wait 30 seconds after onboarding)
4. 🚨 For full experience - Accept Apple Health Permissions in totality
5. Delete and reinstall to experience again
6. Install the Apple Watch app via the Apple Watch App on iOS

## 🛠 How It Was Built

### 🧠 Design of the App

#### Thesis

* High-quality UX, to maximise engagement and data collection  
* As close to a production-grade monetisable state as possible within a reasonable timeframe
* "Two birds one stone" - Components I could reuse in other apps, or the foundation of a new app

#### Quiz was used instead of the standard form:

* To provide a better UI/UIX - it's less daunting as it's one step at a time  
* The upsell screen to increase engagement and completion  
* Quiz is not just for data collection, it's to sell the features of the app again (in anticipation of a paid plan)  

#### Why does the quiz have “Upsell steps” and a  progress bar

* To keep the user motivated to finish the quiz  
* To keep selling to the user usefulness of the app
* To prime them for usage and paywall conversion 

#### Why is quiz data entry at the bottom of the screen

* Closer to the user's thumb — minimises user effort and perceived time spent  
* Increases engagement for long quizzes  
* Faster giving of rewarding feeling of haptic feedback and step completion  

#### Why request notifications during onboarding?

* Early access to notifications can re-engage users if they drop off at the paywall, or in further quiz steps  
* Notifications requested with carrot of “personalised plan” to drive permission for notifications and re-engagement

#### Dashboard appearance

* Dashboard shows a collection of metrics as there are many, and the user needs to see them at a glance  
* Inspired by Apple Health and other top health and fitness metric apps

### 🤝 Assumptions

1. The metric system is used over the imperial system. In production, both should be supported  
2. Assumes the UI/UX is intended to be close to production-grade within a reasonable timeframe (bar accessibility, localisation)
3. Happy path only — assumed sufficient for the challenge (sad paths can be added later i.e. skip quiz step, open in previous state/step)  
4. Retry queues and failed API request persistence were omitted — can be added later if needed  
5. Mock layer is not needed as a HealthKit was used immediatley 
6. Given that this is a simple project 
    1. Security is not a meaninful consideration 
    2. Background data syncing/refreshing whether the app is in the foreground, background or offline was not added

### 🎨 Approach: Design Process
1. Broke down the task into Acceptance Criteria, see (Acceptance Criteria section below)
2. Drafted on whiteboard (see Figure 1)
3. Browsed the internet to view popular health and fitness apps for inspiration (see Figure 2)
4. Designed screen by screen (see Figure 3)

### **Figure 1: Whiteboard**
> Early sketching of core screens, layout strategy, and onboarding logic.
<img src="https://github.com/user-attachments/assets/f7d31e44-5646-4fed-868e-09997650a607" width="300" alt="Whiteboard">

### **Figure 2: Inspiration**
> Screenshots from leading health and fitness apps used to benchmark UI and UX patterns.
<img src="https://github.com/user-attachments/assets/abf203b4-ad02-4dc8-9527-feaf22c03c6a" width="500" alt="Inspiration">

### **Figure 3: Final Design**
> Clean UI focusing on clarity, scannability, and visual appeal for health metric tracking.
<img src="https://github.com/user-attachments/assets/ecf1f6c1-f7b7-41e9-a152-3daa86964f80" width="1000" alt="Final Design">

### **Figure 4: Figma with Commentary**
> Annotated Figma board showing rationale behind key design choices.
<img src="https://github.com/user-attachments/assets/f6b0868f-b26c-487e-9c76-6e2dea57d8a5" width="500" alt="Figma With Commentary">

### **Figure 5: Final iOS App**
> Screenshot of iOS app.
<img src="https://github.com/user-attachments/assets/16260dcf-703d-4ec1-95ad-d22bc3151270" width="500" alt="Figma With Commentary">

### **Figure 6: Final Apple Watch App**
> Screenshot of Apple Watch. The first image shows the "pre-max calorie burn state," and the second shows the "post-max calorie burn state".
<p float="left">
<img src="https://github.com/user-attachments/assets/def360a1-5b9e-4e3e-bd29-f2730cbf5d9e" width="500" align="left">
<img src="https://github.com/user-attachments/assets/30de9238-83f6-487d-bcfc-06666b83af44" width="290" align="left">
</p>
<br clear="all" />


## 🛠 Acceptance Criteria
**AC1: User can enter static data in the onboarding quiz**
* Given I am on the home screen
* When  I tap “Get Started”
* Then I am navigated to a quiz 
* And I can enter the following static data step by step 
    * Blood type
    * Date of birth
    * Gender
    * Height

**AC2: User can connect Apple Health**
* Given that I am viewing the onboarding quiz and I am viewing the Apple Health Screen
* When I the continue button
* Then I can give Apple Health permission for this data 
    * Weight
    * Steps
    * Heart rate
    * Blood glucose
    * (Optional: sleep, calories, temperature, blood pressure, etc.)

**AC3: User give snotification permission** 
* Given that I am viewing the onboarding quiz and I am viewing the Notification Screen
* When I the continue button
* Then I can give notification permissions

**AC4: User views collected data from the dashboard**
* Given that I am viewing the dashboard
* When the dashboard finishes building
* Then I can see the static data entered in AC1 
* And I see Apple Health data if available, as given access to in AC2

## ⚖️ Approach: Balancing Speed and Quality

1. This app was built in a robust way to demonstrate skills set  
2. Some parts were built in a scrappy, fast way to demonstrate the ability to move quickly and make tradeoffs (Testing, Accessibility, Structure)
3. Having worked in startups, a need to balance speed with quality is present  
4. The balance between quality and speed varies depending on product maturity, feature phase/priorities, company lifecycle, and mulifaceted risk tolerance  
5. This project demonstrates one version of that balance — other versions are valid (e.g. more speed, less quality or vice versa)  

## ✅ Unit, Integration & UI Tests
* Given the challenge was focused more on UI/UX, unit and integration tests were less prioritised  
* Unit tests were written to demonstrate skillset in `CoreSharedModelsTests`, `UserBiometricsFeatureTests`  
* One UI test was written in `LaunchViewUITests`  
* No integration tests were written — in other projects, more tests, including Integration tests, would be written with TDD
    * See example from an older poject: [Stocks repo](https://github.com/Tak783/Stocks/tree/main/Layers/Feature/StocksFeedFeature/Tests/StocksFeedFeatureTests))
    * Other more recent examples can be supplied 
* `XCTest` was chosen over `SwiftTesting` for speed and familiarity 

## ⏩ Not Done (for Speed)
1. Accessibility / Dynamic Type & voice over
2. Localisation of strings and metric systems  
3. Back buttons or skip buttons in the quiz
4. Further modularisation
5. Sad paths, resotrative paths, + paywall example
6. Integration tests or extensive unit & UI tests for everything (did a few to demostrate)
7. User Defaults was used instead of SwiftData/CoreData becuase it was simple and easy to test. Given that this was a simple project meaningful security additoins were not a consideration. In a security focused future, SwiftData + Crypto kit (for encryption) + Keychain (for encryption keys) would be used to secure user biometric data + SSLPinning if API calls were introduced, authentication and biometric sign in too.
8. 

## 🧱 Architecture
### Architecture 
* App is built on top of multiple platform-agnostic frameworks that exist inside their own projects, split into layers. Reasoning and design are discussed in the sections below
* Each layer project(framework) can be built and tested on its own, including the Presentation Layer Application targets.
* There are six layers: `Core Foundational`, `Core Healthmax`, `Feature Layer`, `Core Presentation Layer`, `Feature UI`, the `Presentation Layer` 
* Layer dependencies are used vertically: each module can import from layers below or in the same layer,never above
* In this discussion, the bottom layer is `Foundation Layer`, the top layer is `Presentation Layer` 

### Architecture Diagram
<img width="1000" alt="5. Architecture Diagram" src="https://github.com/user-attachments/assets/de66e16d-73a8-47a7-bd23-d7befcda75d0"/>

### Platform Agnostic Components (Reasoning)
Every layer that exists below the presentation layer is built with platform-agnostic components for the following reasons.
* Easily re-use in Mac, iOS, iPadOS, and Watch OS apps using either UIKit, WatchKit or SwiftUI
* Highly *reusable* components that can easily be reused to support other Feature Layer components and Apps
* Faster *build times* for tests, testing suites and projects locally and on pipelines. 
* Easier *collaboration* between teams (everything does not happen in one place)
* Applied Engineering business organisation considerations for *open-sourcing* capability, *hiring* and *demo apps* as layer components are independently relying on abstractions rather than concrete implementation.

### Design and Development (Discussion) 
* Built applying SOLID principles with Unit Tests in some areas.
* Parts of app were built using TDD, ensuring that functionality works as expected and also providing protection from regressions 
* More UI, Unit and Integrations could have been added as discussed in the improvements section
* Business and engineering organisations' considerations were made when constructing this project, as discussed in the previous section.

## Architectural decisions 

<img width="1000" alt="5. Architecture Diagram" src="https://github.com/user-attachments/assets/de66e16d-73a8-47a7-bd23-d7befcda75d0"/>

### Layers (overview)
* As seen in the overview, the app has six layers including `Feature Layer`, `Core Presentation Layer`, `Feature UI`, the `Presentation Layer`
* Each module lives in its own independent project with as few dependencies as possible and contains its own tests; this way, each feature can be:
   *  Built-in isolation without building the entire Presentation Layer App 
   *  Be highly reusable, open sourceable and able to be used in demo apps
   *  Be platform agnostic, usable in any presentation application, target platform
* Vertical dependencies: each layer contains modules used as dependencies by higher-level modules. Modules can import only from the layers below. 

### `Foundation Layer` (explained)
Contains foundational shared frameworks to be shared across multiple presentation layer app targets i.e. iPhone, iPad for business and retail users. The layer contains the following modules; 
* `CoreFoundational`: contains extensions to the `Foundation` framework. These are used across Feature frameworks and the app. 

### `Core Healthmax` (explained)
Key components that support all higher-level layers
* `CoreHealthMaxModels` specific models for Healthmax
* `CoreSharedModels` shared models agnostic to Heathmax. In the future, this will exist one layer lower.

### `Feature Layer` (explained)
Contains modules containing feature business logic
* `UserBiometricsFeature`: Used for manual user data input
* `QuizFeature`: Backend-driven Quiz Feature: just pass in JSON and a dynamic quiz is generated with data collection, upsell, and device permissions
  * See `LocalFetchQuizServiceService`s `.load` function for example of how this works,  
* `CoreHealthKit` is supposed to be a generic method for interfacing with HealthKit, and is supposed to be used by other features. For now, it also contains Heathmax specific code i.e. `HealthKitHealthDataService`

### `Core Presentation Layer` (explained)
Holds supporting extensions and components for presentation layer components and apps.
* `CorePresentation` Holds the Design System and Reusable components to support presentation layer components and apps. 
* `CoreUIKit` Holds extensions to UIKit

### `Feature UI Layer` (explained)
Consumes Feature Layer packages into presentable view components to be consumed by apps
* `QuizFeatureUI` Backend-driven Quiz Feature presentation 

### `Presentation Layer` (explained)
`Presentation Layer`: Where apps Mac, iOS, iPadOS, Watch OS use the feature frameworks and other level components to present features for users
* `Healthmax`: simple app to collect health data manually and using Apple Health to then present users with a customised plan to maximise their health 
* Other apps such as `HeartGuide` or `FitnessMaxiOS` could be built to re-use higher-level layers

## 🔮 Future Changes
1. Simple Open AI analysis of user data and a custom plan for what the user could do to maximise their health 
2. More unit, integration, and UI tests across all modules  
3. A separate test helper Swift package to support extensions like `XCTest+Result`  
4. Move permission request views and logic from `QuizFeature` into standalone feature packages  
5. Move `Coordinator` into `CorePresentation` or a dedicated navigation package  
6. Move generic supporting views into a shared components package (same with `DesignSystem`)
7. Use a new quiz service instead of saving data manually 
8. Add missing UI states — e.g., when Apple Health permission is skipped
9. Other suggestions as documented earlier in README
10. Periodic Background refresh (as discussed earlier) when app is in the forergound 
11. Accessibility (even with colour scheme) & voice over
12. Adhere to this `https://codershigh.github.io/guidelines/ios/human-interface-guidelines/technologies/healthkit/index.html` i.e. refering to HealthKit or using apples Icons
13. Add an upsell screen for blood type as its an odd thing to ask 

## 🔐 Future Production Grade Security Upgrades
If the app was to go beyond the scope of the team and make it to production these are the changes I'd make for security 
1. Use Swift Data + Cryptokit and Keychain instead of User Defaults for Security reasons disucssed earlier
2. Biometric unlock for security reasons
3. Add jailbreak check to block users from using the app if its jailkbroken 
4. Ask for biometric enrolment again if a user takes a screenshot, only then can it be saved

------

## ⭐️ v0.20 Completed Upgrades 
1. MaxPlan View: Healthmax now returns custom AI generated insights from Static and dynamic (HealthKit) data

## ⭐️ v0.21 Completed Upgrades 
1. New Apple Watch companion app "Max Calorie Burner" helps users maximise their calorie burn with tips based on their calories burned for the day sourced from HealthKit

Notes
* This was a quick integration E2E
* Integration uses Firebase and OpenAI to power the service that returns personalised insights
* Can be improved E2E from architecture, re-usability and testing
* Best experienced using real data from Apple Health, to try, just run the app on device

---
Thank you for your consideration :) 
