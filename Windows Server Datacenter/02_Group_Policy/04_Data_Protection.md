# Group Policy: Data Protection

Removable storage is the easiest way to take data out of a company. Two policies restrict it for the departments that handle sensitive files, with a level of restriction adapted to each department.

## Summary

| GPO | Linked to | Restriction |
|---|---|---|
| GPO - USB Restriction - Finance | `OU_Finance` | Removable storage fully denied |
| GPO - USB Restriction - HR | `OU_HR` | Write denied, read allowed |

Both policies are **user** settings, so they follow the user: the restriction applies to a Finance or HR user on any machine, and does not affect other users of the same machine.

---

## GPO - USB Restriction - Finance

**Scope**: linked to `OU_Finance`.

**Why**: the Finance department handles financial data, so no file may leave on a removable disk, and no external file may enter. The policy denies read and write access to removable storage.

**Configuration**

![GPO - USB Restriction - Finance settings](images/usb_finance_settings.png)

### Verification

#### V1. Removable disk blocked for Finance

- **Test**: on the client, sign in as a Finance user and attach a removable disk.
- **Expected**: the disk cannot be opened and Windows reports that access is denied.
- **Result**: ✅

![Removable disk denied for a Finance user](images/test_usb_finance_denied.png)

#### V2. Other departments are not affected

- **Test**: attach the same removable disk and sign in as an IT user.
- **Expected**: the disk opens normally, which proves that the policy is limited to its OU.
- **Result**: ✅

![Removable disk usable by an IT user](images/test_usb_it_allowed.png)

---

## GPO - USB Restriction - HR

**Scope**: linked to `OU_HR`.

**Why**: HR staff legitimately import documents such as CVs from removable disks, so reading is allowed. Writing is denied, which prevents personal data from leaving on a disk. The restriction is lighter than for Finance because the need is different.

**Configuration**

![GPO - USB Restriction - HR settings](images/usb_hr_settings.png)

### Verification

#### V1. Reading allowed

- **Test**: on the client, sign in as an HR user, attach a removable disk that contains a file and open it.
- **Expected**: the file can be read.
- **Result**: ✅

![Removable disk readable by an HR user](images/test_usb_hr_read.png)

#### V2. Writing denied

- **Test**: with the same user, copy a file to the removable disk.
- **Expected**: the copy is refused.
- **Result**: ✅

![Write to a removable disk refused for an HR user](images/test_usb_hr_write_denied.png)
