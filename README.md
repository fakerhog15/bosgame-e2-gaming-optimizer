# BOSGAME Mini PC E2 Gaming Optimizer

[![GitHub Release](https://img.shields.io/github/release/fakerhog15/bosgame-e2-gaming-optimizer.svg)](https://github.com/fakerhog15/bosgame-e2-gaming-optimizer/releases)
[![GitHub License](https://img.shields.io/github/license/fakerhog15/bosgame-e2-gaming-optimizer.svg)](https://github.com/fakerhog15/bosgame-e2-gaming-optimizer/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/fakerhog15/bosgame-e2-gaming-optimizer.svg)](https://github.com/fakerhog15/bosgame-e2-gaming-optimizer/stargazers)

## 🖥️ About

**BOSGAME Mini PC E2** gaming optimization script for Windows 11 Pro.

Optimized for the **AMD Ryzen 5 3550H** with **Radeon Vega 8 Graphics** configuration.

This script applies system-level tweaks to squeeze out the best possible gaming performance from this budget mini PC, specifically targeting smooth **VRChat** desktop mode performance.

## 📋 Hardware Specifications

- **CPU:** AMD Ryzen 5 3550H (4 cores, 8 threads, up to 3.7GHz)
- **iGPU:** AMD Radeon Vega 8 (8 graphics cores, up to 1.2GHz)
- **RAM:** 16GB DDR4 (dual-channel, upgradable to 32GB)
- **Storage:** 512GB NVMe SSD (upgradable to 2TB)
- **OS:** Windows 11 Pro (pre-installed)
- **Graphics Memory:** Shared system RAM

## 🎯 What the Script Does

The optimization script applies the following tweaks:

| Category | Tweaks Applied |
|----------|----------------|
| **Game Mode** | Enables Windows 11 Game Mode for better foreground game priority |
| **Power Settings** | Sets High Performance power plan, max CPU states |
| **Visual Effects** | Disables transparency, sets performance priority |
| **Background Services** | Reduces Windows Search indexing, disables Game Bar for non-games |
| **Network** | Optimizes TCP window size, disables QoS reservation for lower latency |
| **Radeon Vega 8** | Attempts AMD registry tweaks (DCA, memory allocation, FSR support) |
| **VRChat Setup** | Configures launch directory and basic config |

## 🚀 How to Use

1. **Download** the `optimize_bosgame_e2.bat` from the [Releases page](https://github.com/fakerhog15/bosgame-e2-gaming-optimizer/releases)
2. **Right-click** the `.bat` file and select **"Run as administrator"**
3. **Restart** your PC for all changes to take full effect
4. Launch **VRChat** and enjoy optimized performance

## ⚠️ Important Notes for VRChat on Ryzen 5 3550H + Vega 8

- **Desktop mode only** - VR mode is too demanding for this hardware
- **Resolution:** Play at 1080p or lower for smooth performance
- **Graphics Settings:** Use Medium or Low in VRChat settings
- **Close all other applications** before launching VRChat
- **Update AMD graphics drivers** via Adrenalin Software for best Vega performance
- The integrated Vega 8 graphics shares system RAM - having 16GB dual-channel RAM is critical

## ⚙️ Manual Tweaks (If Applying Individually)

- **Game Mode:** Settings → Games → Game Mode → On
- **Power Plan:** Control Panel → Power Options → High Performance
- **Visual Effects:** System → Advanced → Performance → Settings → "Adjust for best performance"
- **Network:** Set Active Hours to avoid restarts during gaming sessions

## 📦 Release

- **v1.0** - Initial release with core gaming optimizations
- Contains: `optimize_bosgame_e2.bat`

## 🛡️ Backup

The script creates a registry backup at `C:\BOSGAME_Optimize_Backup` before making changes. If anything goes wrong, you can restore from this backup.

## 💡 Tips for Best VRChat Performance

1. **RAM:** Ensure you're running dual-channel (2x8GB) - check with Task Manager → Performance → Memory
2. **SSD:** The NVMe SSD helps with world loading times
3. **Drivers:** Keep AMD Adrenalin drivers updated
4. **Background:** Use Task Manager to close unnecessary apps before VRChat
5. **VRChat Settings:** Lower avatar rendering quality, reduce physics quality

---

*Optimized for BOSGAME Mini PC E2 Ryzen 5 3550H + Vega 8. Runs best in Desktop (2D) VRChat mode.*
