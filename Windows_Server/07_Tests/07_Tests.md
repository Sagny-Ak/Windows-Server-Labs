# Validation Tests

## Test Environment

| Component | Value |
|---|---|
| Client OS | Windows 10 (DESKTOP-J3MTIO5) |
| Domain user | VITALTECH\kmensah |
| Domain | vitaltech.local |
| DC | SRV-VT01 |

---

## Test 1 — Domain Membership

```cmd
systeminfo | findstr /i "domaine"
```

**Expected:** `Domaine: VITALTECH`
**Result:** ✅ Client confirmed member of VITALTECH domain

---

## Test 2 — DNS Resolution

```cmd
nslookup vitaltech.local
```

**Expected:** Server resolves to `172.16.10.1`
**Result:** ✅ DNS resolving correctly

---

## Test 3 — Server Ping

```cmd
ping SRV-VT01.vitaltech.local
```

**Expected:** Reply from `172.16.10.1`
**Result:** ✅ Server responding

---

## Test 4 — GPO Applied (gpresult)

```cmd
gpresult /r
```

**Applied GPOs confirmed:**
- GPO_Lecteur_Direct ✅
- GPO_fond_ecran ✅
- GPO_account_lock_up ✅

**User group membership confirmed:**
- GG_Direction ✅
- DL_Direction ✅

---

## Test 5 — Drive Mapping

**Expected:** Drive `B:` mapped to `\\172.16.10.1\Direction$`
**Result:** ✅ Drive visible in File Explorer under "Network Locations"

---

## Test 6 — Corporate Wallpaper

**Expected:** VitalTech SARL wallpaper deployed via NETLOGON
**Result:** ✅ Wallpaper applied automatically on login — no user action required

---

## Test 7 — Share Access

```cmd
dir \\SRV-VT01\Direction$
```

**Expected:** Contents of Direction share visible
**Result:** ✅ Access granted to kmensah (member of GG_Direction → DL_Direction)

---

## Summary

| Test | Result |
|---|---|
| Domain membership | ✅ |
| DNS resolution | ✅ |
| Server connectivity | ✅ |
| GPO applied | ✅ |
| Drive mapping | ✅ |
| Corporate wallpaper | ✅ |
| Share access | ✅ |
