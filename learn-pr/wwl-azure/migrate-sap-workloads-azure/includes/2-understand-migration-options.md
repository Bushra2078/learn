## Classical Migration

With the Classical Migration option, SAP’s Software Provisioning Manager (SWPM) is used as the Software Logistics (SL) tool and is exclusively for database migrations. SWPM exports from data from a source system and imports it to a target system where the target can be anyDB (SQL server, Oracle, or DB2). This method in particular uses a file-based approach.

## SAP Database Migration Option (DMO)

DMO facilitates both an SAP upgrade and a database migration to the SAP HANA database using one tool. As both steps are handled at once, the DMO process is often referred to as a one-step migration. In comparison, Classical Migration uses a heterogenous system copy approach (thus garnering it the title of a two-step migration) with the first step being that of a migration followed by a second step facilitating an SAP upgrade.

## Classical migration vs DMO

| Parameter | Classical migration | DMO |
|-----------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| Purpose/Use Case | Migration only | <p><ul><li>Upgrade + Migration</li><li>New DMO version available for migration-only option</li></ul></p> |
| Downtime Optimization Flexibility | High | Medium |
| Migration | Manual | Automated |
| Migration Expertise | OS/DB certification is mandatory | OS/DB is not mandatory, but highly recommended |
| Data Consistency | Manual | Automatic |
| Options for Data Transfer | <p><ul><li>Socket mode option</li><li>Net exchange mode option</li><li>FTP mode option to transfer data</li></ul></p> | <p><ul><li>Memory pipes</li><li>Filesystem dump</li></ul></p> |
| Migration Check Service | Migration check service required for classical approach on productive systems | No migration check service required for DMO on productive systems. |
| Monitoring Progress | Distribution monitor and migration monitor tools available | Built-in SAPUI application for monitoring progress |
| Post-migration Consistency Check | Process is manual and requires MIGCHECK tool and the time analyzer tool to generate reports | Built-in feature in DMO |
| Table Splitting | Dedicated table splitting and package splitting tools available – R3TA, R3ZCHECK | Table splitting is built-in and tuned |
| Import and Export Table Splitting | Table splitting for export and import can be changed on the fly | Table splitting and sorting requires adjustment as part of uptime (not on the fly) |
| DDL Statements | Manual process to generate all DDL statements prior to migration | Built-in process for DDL statement calculations and deployment |
| SWPM, MIGMON, DISMON | <p>SWPM, Migration Monitor (MIGMON) and Distribution Monitor (DISTMON) can be started and stopped manually</p><p>Not recommended to run from remote desktops for MIGMON tools</p> | <p>No such option available in DMO</p><p>No such restrictions in DMO</p> |
| Export/Import | Ability to add multiple application servers to run the export/import | Only one application server can be used |
| R3 Load Process Limit | No limits | Limit of 999 R3 load processes |
| Table Splits Limit | No limit on number of table splits | Limit of 200 table splits |
| Target DB | anyDB (e.g. SAP HANA, SQL server, Oracle, DB2, etc.) | Only SAP HANA, AS (other databases are available upon request) |
| SAP Recommendation | SAP recommended option if no software change is involved | SAP recommended option if SAP upgrade is in scope |

