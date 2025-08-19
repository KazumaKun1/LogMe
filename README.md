# LogMe
An app to simulate login

## Appendix

This project is using:
- Swift 6.1
- SwiftUI
- MVVM Architecture
- Unit Tests

In order to run this you need to have:
- Xcode 16.4 but you can try to use Xcode 16.xx.
    - This is to avoid issues when running this project on lower versions of xcode and macOS.
- macOS Sequioa 15+ since this is the version where the Xcode 16 series will run.
- iOS 18.5 for the simulator since it's the minimum deployment
- __(Optional)__ Sourcetree for easier cloning but you can clone this using Git terminal.

After cloning the project, make sure that you select __main__ as the main branch.
After selecting the branch, you can open the project by:
- Opening xcode 16.4
- Selecting "Open a project or file"
- Browse using the path that you save during cloning
- Find the __.LogMe.xcodeproj__ file then open it
Then in order to run the project you can simply press __ctrl + R__ on your keyboard to build and run.

## Apple Framework used
- SwiftUI
- Testing
- CryptoKit

## Folder Structure
- LogMe
  - Main
    - Common
      - Enums
      - Extensions
      - Mocks
      - Services
      - Views
        - Modifiers
    - Model
    - View
    - ViewModel
- LogMeTests
- LogMeUITests

## Features/Functionality

- Tap anywhere on the screen to get a new fact of cats with image with randomized fonts that supports dynamic types
- It will use your selected/accent color that has been set on the device while the image is loading
- Semi-localization on the cat facts depending on your preferred language that has been set on your device's settings
- Share feature to share with anyone
- Accessibility support
- Dark mode support
- Supported iPhone and iPad screens

## Video (IPhone)
Uploading LogMe - IPhone.mov…

## Video (IPad)
Uploading LogMe - IPad.mov…

## Screenshots (IPhone - Portrait)



## Screenshots (IPhone - Landscape)


## Screenshots (IPad - Portrait)


## Screenshots (IPad - Landscape)

