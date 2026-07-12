# DeutschLernen

DeutschLernen is a SwiftUI-based iOS app for capturing everyday German expressions and revisiting them through a lightweight review flow.

## Overview

The app focuses on real-life phrases rather than formal grammar drills. Users can save Turkish-to-German expressions, review them in a card-based experience, and gradually build familiarity through repeated exposure.

## Technical Focus

The project is being developed as a personal learning and portfolio app with emphasis on modern Apple platform technologies:

- SwiftUI for the user interface
- SwiftData for local persistence
- App Groups for shared data access between app, widget, and intents
- App Intents and Shortcuts integration for capture workflows
- WidgetKit for lightweight, interactive reminders

## Architecture

The app is designed to be local-first and offline-capable. Shared data is stored in a SwiftData container configured for App Groups so the main app, capture flow, and widget can access the same content.

## Development Plan

The implementation is organized in phases:

1. Project setup and shared data layer
2. Capture flow via App Intents and Shortcuts
3. CRUD interface and card-based UI
4. Review/test experience with Leitner-style progression
5. Widget integration and polish

## Notes

This repository is intended for personal development and experimentation with Apple framework integration in a practical product context.
