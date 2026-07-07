# Studio Code Live!
Studio Code Live is an interactive, high-production asymmetric party game ecosystem designed specifically for live streamers to act as televised game show hosts with their communities. Drawing heavy inspiration from the vibrant, neon-soaked nostalgia of late-80s and early-90s network television , this project bridges the gap between desktop gaming clients and real-time audience interaction panels.

[![Engine](https://img.shields.io/badge/Engine-Godot_4.6+-blueviolet?style=for-the-badge&logo=godot-engine&logoColor=white)](https://godotengine.org)
[![Backend](https://img.shields.io/badge/Backend-Node.js_&_Socket.io-green?style=for-the-badge&logo=node.js&logoColor=white)](https://nodejs.org)
[![Style](https://img.shields.io/badge/Aesthetic-1980s_Neon_Retro-ff69b4?style=for-the-badge)](https://en.wikipedia.org/wiki/Synthwave)

---

### 🕹️ Welcome to the Control Room

**Studio Code Live** is an interactive, high-production asymmetric party game ecosystem designed specifically for live streamers to act as televised game show hosts with their live audience communities. 

Drawing heavy inspiration from the vibrant, neon-soaked nostalgia of late-80s and early-90s network television, this project bridges the gap between local desktop gaming clients and real-time audience interaction panels without stream latency friction or stream-sniping vulnerabilities.

---

## 🏗️ Core Ecosystem Architecture

Unlike traditional party games that stream a single screen causing input delays, **Studio Code Live** splits the experience into distinct multi-platform application profiles managed under a centralized switchboard:

### 1. The Broadcast Studio Booth (Desktop Client)
A dual-purpose controller layout built in **Godot 4**. 
* **Left Side (Confidential Host Controls):** Houses secure, confidential host configurations, admin moderation tables, game setup modules, and user profile saves (`user://studio_settings.cfg`).
* **Right Side (Public Stream Display):** Stays locked to a presentation-ready 16:9 widescreen viewport rendered explicitly for the public live stream capture software.

### 2. The Live Studio Audience (Cross-Platform Web Portal)
A zero-friction entry system for mobile or desktop web browsers. Viewers connect to the host's session simply by navigating to the room address and entering a localized studio room key and custom username.

### 3. The Switchboard Router (Real-Time Backend)
A high-performance **Node.js & Socket.io** backend server that handles data aggregation, automated team assignment logic, mathematical accuracy calculations, and sub-second event relay synchronization across all active devices.

---

## 🚀 Key Features

* **Hybrid Player Architecture:** Seamlessly accommodates casual web-browser participants alongside regular community members using a fast name entry validation pipeline.
* **Automated Team Allocation:** Instantly splits incoming viewer web connections 50/50 into rival 80s arcade factions: **The Neon Retro Cats 🐱** vs. **The Cyber Laser Sharks 🦈**.
* **Global Hardware Fail-Safe:** Features an unblockable, engine-level safety escape sequence (`Shift + H + Numpad 5`) integrated globally across all scenes to immediately kill the client if trapped in unhandled prototype states.
* **Local Profile Configuration:** Persistently stores, tracks, and loads custom studio setup allocations (such as player caps, active modules, and scoreboard flags) directly via native local Config text profiles.

---

## 🎮 Included Mini-Games

### 🟩 1. The Neon Grid (Team Trivia)
A classic 3x3 grid-bound match where the host selects a grid tile and broadcasts a live question. Viewer web browsers automatically adapt into multi-choice selection pads (A, B, C, D) themed to their faction. When time expires, the server calculates aggregate data, assesses team accuracy ratings, and repaints the grid tile permanently on stream into the winning faction's neon color.

### 💰 2. Bidding War (Numeric Precision)
A numeric data-gathering game following classic television game show mechanics. The host inputs a custom trivia item and target answer directly inside their dashboard console. The audience has 30 seconds to type their precise numeric guess into their phone controllers. The central backend processes variances, filters duplicates, and crowns the closest player without going over.

---

## 🛠️ Built With

* **Front-End Engine:** Godot 4 (GDScript / UI Theme Overrides)
* **Backend Infrastructure:** Node.js (Express Framework)
* **Real-Time Communications:** Socket.io (Engine.IO WebSocket Protocol)
* **Web Portal Elements:** Semantic HTML5 & Vanilla JavaScript

---

## 🏁 Quick Start & Developer Guide

### 1. Launch the Switchboard Server
Ensure you have Node.js installed, open your terminal inside the server project directory, and run:
```bash
# Clear out lingering ports if stuck
npx kill-port 3000

# Start the Node.js backend
node server.js
2. Run the Broadcaster Client
Open the project folder in Godot 4.6+.

Go to Project Settings -> Application -> Run and ensure your main run target scene is set to loading_splash.tscn.

Press F5 to start.

Pass through the diagnostic disclaimer screen and press Spacebar to enter the master title layout.