# Credits & Attributions: AM2R Multitroid Co-op

This project is a non-commercial, community-driven cooperative modification for *Another Metroid 2 Remake* (AM2R), built upon years of passion, reverse-engineering, and collaborative modding by many talented developers and artists.

We express our deepest gratitude to everyone who contributed to AM2R, the Multitroid mod lineage, and the open-source tools that made this co-op experience possible.

---

## 🌳 Project Lineage & Heritage

The history of this project spans several generations of community development:

```
Metroid II: Return of Samus (1991, Nintendo)
  │
  └── AM2R: Another Metroid 2 Remake (DoctorM64 & Martin Piecyk, 2016)
        │
        └── AM2R Community Updates (AM2R Community Developers / Team-Z, 1.5+)
              │
              └── AM2R-Multitroid (milesthenerd)
                    │
                    └── AM2R-Multitroid-Unofficial-Patch (DodoBirby)
                          │
                          └── AM2R-Multitroid-Unofficial-Unofficial 1.9.x (VanessaMae1087)
                                │
                                └── AM2R Multitroid Co-op (This Project)
```

---

## 🎮 Original Game & Base Project

### **AM2R: Another Metroid 2 Remake**
* **Lead Creator & Game Designer:** Milton Guasti ([DoctorM64](https://twitter.com/DoctorM64))
* **Lead Programmer:** Martin Piecyk
* **Website / Blog:** [metroid2remake.blogspot.com](http://metroid2remake.blogspot.com/)
* **Description:** The legendary fan remake of *Metroid II: Return of Samus* developed over nearly a decade and released in August 2016.
* **License:** Copyright (c) Milton Guasti & Martin Piecyk. All rights reserved.

### **AM2R Community Updates Development Team**
* **Developers:** Team-Z & AM2R Community Developers
* **Repositories:** [AM2R-Community-Developers GitHub](https://github.com/AM2R-Community-Developers)
* **AM2RLauncher:** [AM2RLauncher Repository](https://github.com/AM2R-Community-Developers/AM2RLauncher)
* **Description:** Dedicated team that maintained and enhanced AM2R through versions 1.2 to 1.5.5, adding widescreen support, custom palettes, HQ music, quality-of-life updates, and the official mod launcher.
* **License:** AM2R Community Updates License (Strictly educational and maintenance purposes). AM2RLauncher is licensed under GNU GPL-3.0.

---

## 🌐 Multitroid Mod Lineage

### **1. Original Multitroid**
* **Author:** milesthenerd
* **Repository:** [https://github.com/milesthenerd/AM2R-Multitroid](https://github.com/milesthenerd/AM2R-Multitroid)
* **Description:** The pioneer project that brought multiplayer netcode, dedicated server architecture, player sync, and PvP / co-existence to AM2R.
* **License:** Server & Multitroid additions licensed under the MIT License.

### **2. Multitroid Unofficial Patch**
* **Author:** DodoBirby
* **Repository:** [https://github.com/DodoBirby/AM2R-Multitroid-Unofficial-Patch](https://github.com/DodoBirby/AM2R-Multitroid-Unofficial-Patch)
* **Description:** Substantial overhaul fixing long-standing synchronization bugs, improving stability, and introducing modern modding workflow integration.

### **3. Multitroid Unofficial-Unofficial (1.9.0 - 1.9.2)**
* **Author:** VanessaMae1087
* **Repository:** [https://github.com/VanessaMae1087/AM2R-Multitroid-Unofficial-Unofficial](https://github.com/VanessaMae1087/AM2R-Multitroid-Unofficial-Unofficial)
* **Description:** Added customizable SA-X mode, suit customizations, palette options, and updated netcode stability.

### **4. AM2R Multitroid Co-op (This Project)**
* **Authors & Contributors:** Community Co-op Team
* **Features Introduced:**
  - **Full Room & Enemy Authority Synchronization:** Host dynamic authority, enemy HP, state, position, and death synchronization.
  - **Dynamic Host Transfer:** Smooth room ownership transfer when players enter or leave rooms independently.
  - **Shared Major Upgrades:** Missiles, Super Missiles, Power Bombs, and suit abilities sync across all connected players.
  - **Independent Expansion Tanks:** Each player tracks their own collected expansion tanks, allowing personal progression.
  - **Dynamic Co-op HP Scaling:** Intelligent enemy and boss health scaling (+20% HP for regular enemies, +40% HP for bosses per additional player in the room).
  - **Individual Respawn System:** Individual respawn at personal save points without breaking session state.
  - **1-Click AM2RLauncher Integration:** Complete mod profile with automated delta patching from clean AM2R 1.1 or Multitroid 1.9.2.

---

## 🛠️ Modding Tools & Third-Party Libraries

* **[UndertaleModTool (UTMT)](https://github.com/krzys-h/UndertaleModTool)**
  - *Authors:* krzys-h, Grossik, and the UTMT Community
  - *License:* GNU General Public License v3.0 (GPL-3.0)
  - *Role:* Invaluable bytecode disassembly, asset extraction, and injection tool for GameMaker: Studio datafiles.

* **[YAM2RP (Yet Another Metroid 2 Remake Patcher)](https://github.com/DodoBirby/YAM2RP)**
  - *Author:* DodoBirby
  - *License:* MIT License
  - *Role:* Source-controlled patching framework used to maintain clean Git diffs for GameMaker code, objects, and rooms.

* **[XDelta3](https://github.com/jmacd/xdelta)**
  - *Author:* Joshua MacDonald
  - *License:* Apache License 2.0 / GNU GPL-2.0
  - *Role:* Binary delta compression algorithm used to generate legal, copyright-safe distribution patches.

* **Acknowledge Font (`Acknowledge_TT_BRK.ttf`)**
  - *Author:* Brian Kent (Aenigma Fonts)
  - *Role:* Server GUI and in-game typography.

---

## ⚖️ Legal & Fair Use Disclaimer

- **METROID** and all related characters, logos, audio, and visual assets are registered trademarks and copyrights of **Nintendo Co., Ltd.**
- This project is a **non-commercial, fan-made educational work** created under fair use principles. It is **not** endorsed by, sponsored by, or affiliated with Nintendo Co., Ltd. in any way.
- **No copyrighted game assets or complete game binaries are distributed** with this project. Players must provide their own legally acquired copy of AM2R 1.1 to generate the patched files.
- No commercial revenue, donations, or monetization of any kind are accepted for this project.
