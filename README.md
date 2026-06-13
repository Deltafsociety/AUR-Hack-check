# AUR Package Audit Snapshot

This repository contains a snapshot of AUR packages from a system, along with a helper script that verifies whether those packages are installed using `yay`.

It was created in response to recent security incidents affecting the Arch User Repository (AUR), where multiple packages were reported as compromised through malicious changes in build scripts. The goal is to improve visibility and auditing of AUR packages installed on a system.

## Purpose

The AUR allows users to install community-maintained packages, but it also introduces a supply-chain risk because:

* PKGBUILDs execute arbitrary code during build
* Packages are maintained by individual users
* Compromised maintainer accounts can affect many users
* Build-time scripts may change without immediate detection

This repository is intended as a simple audit mechanism to:

* Track installed AUR packages
* Compare a known list against installed packages
* Identify unused or missing packages
* Support system cleanup and risk reduction

## Contents

```
aur_list.txt        List of AUR package names
check_aur_yay.sh    Script to verify installation status using yay
remove_aur.sh       (Generated) Script to remove installed packages
README.md           Documentation
```

## Requirements

* Arch Linux or Arch-based system
* yay AUR helper installed

## Usage

Make the script executable:

```bash
chmod +x check_aur_yay.sh
```

Run the audit:

```bash
./check_aur_yay.sh aur_list.txt
```

This will:

* Check which packages are installed via `yay -Qm`
* Print installed and missing packages
* Generate a removal script (`remove_aur.sh`) for installed packages

## Optional Cleanup

To remove all detected installed packages:

```bash
chmod +x remove_aur.sh
./remove_aur.sh
```

## Security Context

This repository was created following a reported incident affecting the AUR ecosystem where a large number of packages were modified to include malicious behavior during installation or build time.

The AUR is not officially curated, and users are responsible for verifying PKGBUILDs before installation. This project is a personal audit tool to reduce blind trust in installed AUR software.

## Limitations

* This is a static snapshot, not real-time monitoring
* Package status may change after creation of this list
* The script does not analyze PKGBUILDs or detect malicious code
* It only checks installation state via `yay`

## License

MIT

---

If you want, I can also refine this further into a more “security audit report” style or turn it into something like a formal system hardening document.

