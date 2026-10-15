# AM2R Multitroid Co-op

A full cooperative multiplayer overhaul for **Another Metroid 2 Remake (AM2R)**.

Built on the foundation of the Multitroid lineage:
* Unofficial fork of [VanessaMae1087's Multitroid Unofficial-Unofficial](https://github.com/VanessaMae1087/AM2R-Multitroid-Unofficial-Unofficial)
* Based on [DodoBirby's Unofficial Patch](https://github.com/DodoBirby/AM2R-Multitroid-Unofficial-Patch/)
* Original mod by [milesthenerd](https://github.com/milesthenerd/AM2R-Multitroid)
* Base game by Milton Guasti ([DoctorM64](https://twitter.com/DoctorM64)) & Martin Piecyk

---

## ✨ Features

- 🤝 **Full Co-op Enemy & Boss Synchronization:**
  - Real-time synchronization of enemy states, positions, HP, projectiles, and deaths across all players in the same room.
  - Dynamic host authority transfer: Seamless room ownership transfer when players enter or leave rooms independently.
- ⚡ **Shared Abilities & Major Upgrades:**
  - Picking up major abilities (Missiles, Super Missiles, Power Bombs, Suits, Beam upgrades, Movement upgrades) grants them to all connected players simultaneously.
- 🎒 **Independent Expansion Tanks:**
  - Energy Tanks, Missile Expansions, Super Missile Expansions, and Power Bomb Expansions are tracked independently for each player, preserving personal exploration and progression.
- ⚖️ **Dynamic Co-op HP Scaling:**
  - Intelligent difficulty scaling to ensure engaging co-op combat:
    - Regular enemies: +20% HP per additional player in the room.
    - Bosses & Metroids: +40% HP per additional player in the room.
- 🔄 **Individual Save & Respawn:**
  - Players respawn cleanly at their own last visited save point without interrupting other connected players.
- 🚀 **1-Click AM2RLauncher Integration:**
  - Ready-to-install profile for the modern [AM2RLauncher](https://github.com/AM2R-Community-Developers/AM2RLauncher), generating a patched client with zero manual hex-editing or file replacing.
- 🖥️ **Standalone Dedicated Server:**
  - Lightweight, dedicated server that can be run on local networks or forwarded for internet play.

---

## 📥 Installation & How to Play

### Option 1: Via AM2RLauncher (Recommended)
1. Download `AM2R_Multitroid_Coop_Launcher_Mod.zip` from Releases.
2. Open **AM2RLauncher** (v2.3.0 or newer).
3. Navigate to **Mod Settings** -> **Install Mod from Zip** and select `AM2R_Multitroid_Coop_Launcher_Mod.zip`.
4. The launcher will automatically verify your clean AM2R 1.1 `data.win` and generate the playable Co-op profile.
5. Launch the mod profile from the launcher!

### Option 2: Hosting a Server
1. Download `AM2R_Multitroid_Coop_Server.zip`.
2. Extract and run `AM2R Server.exe`.
3. By default, the server listens on UDP port `6510`. (Ensure port 6510 is forwarded on your router if playing over the internet, or use tools like Radmin VPN / ZeroTier / Tailscale).
4. In-game, open the multiplayer menu, type the host IP address and port, and connect.

---

## 🛠️ Building From Source

This project uses [YAM2RP](https://github.com/DodoBirby/YAM2RP) and [UndertaleModTool (UTMT)](https://github.com/krzys-h/UndertaleModTool) (version 0.7.0.0 recommended) to patch and export bytecode and datafiles.

1. Obtain a Multitroid 1.9.0 / 1.9.2 `data.win` or base AM2R 1.1 `data.win`.
2. Use YAM2RP to apply scripts from `Client_YAM2RP` or `Server_YAM2RP`:
   ```bash
   YAM2RP path/to/base.data.win path/to/Client_YAM2RP path/to/output.data.win
   ```
3. Open `output.data.win` in UndertaleModTool to inspect or compile.

---

## 📜 Credits, Attributions & Licenses

- Please refer to [CREDITS.md](CREDITS.md) for full attribution of all original authors, modders, and open-source tools.
- Please refer to [LICENSES.md](LICENSES.md) for complete license notices and Nintendo IP disclaimer.

---

## ⚖️ Legal Disclaimer

AM2R Multitroid Co-op is a non-commercial fan project created for educational and entertainment purposes. It is **not** affiliated with, endorsed by, or sponsored by Nintendo Co., Ltd. Metroid and Samus Aran are trademarks of Nintendo.