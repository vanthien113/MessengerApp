# MacOS Messenger App

A lightweight, native macOS wrapper for [Messenger.com](https://www.messenger.com), built with Swift and SwiftUI.

## Features

- **Native Window Experience**: Runs Messenger in its own dedicated window, separate from your browser tabs.
- **Smart Link Handling**:
    - Keeps Messenger navigation internal.
    - Opens external links (YouTube, Google, Facebook, etc.) in your default web browser.
- **Window State Persistence**: Remembers your window size and position across application launches.
- **Drag-and-Drop Installation**: Includes a user-friendly DMG installer.

## Installation

1. Download the latest `MessengerApp.dmg`.
2. Open the DMG file.
3. Drag the `MessengerApp` icon into the `Applications` folder shortcut.
4. Launch the app from your Applications folder.

## Building from Source

To build this project locally, you need Xcode installed.

1. Clone the repository.
2. Navigate to the project directory:
   ```bash
   cd MessengerApp
   ```
3. Build the project:
   ```bash
   swift build -c release
   ```
4. Run the app:
   ```bash
   swift run
   ```

## Author

- **Huynh Van Thien** - [Connect on Facebook](https://www.facebook.com/thien.huynhvan.35/)

## Credits

**Vibe Coded by AntiGravity** 🚀

This project was built using **AntiGravity**, an advanced AI coding assistant by Google DeepMind. It demonstrates the power of AI-assisted software development, from initial scaffolding to complex feature implementation like window state restoration and navigation policy handling.
