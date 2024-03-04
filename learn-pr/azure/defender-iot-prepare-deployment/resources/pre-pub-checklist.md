# Pre-publication checklist
1. Metadata
1. Content/Media/assets
1. Index.yml
1. All other yml files
1. Exercises
  
## Metadata
- [X] is the uid set in all yml files?

### Content/Media/assets
- [] Remove locale from urls
- [] Final images/screenshots are present
- [] Badge images are present
- [] Verify Acrolinx score for all content (score > 80)

### Index.yml
- [] *title* is set
- [] *description* is set and follows guidelines (doesn't duplicate title)
- [] *summary* is set and follows guidelines
- [] *abstract* is set and lists objectives (no periods)
- [] *prerequisites* are set
- [X] *ms.date* is set to publication date
- [X] *author* and *ms.author* are set
- [X] *ms.service* is set to appropriate value
- [] *iconUrl* is set and points to a valid svg
- [] *badge* has *uid* child set to uid
- [] all units are listed

### All other yml files
- [X] *uid* is set and matches index.yml
- [] *title* is set
- [X] *ms.date* is set 
- [] *author* and *ms.author* are set
- [] *durationInMinutes* is set and IS ACCURATE
- [] *interactive* is set to **bash** or **azure-portal** (if exercise)
- [N/A] *azureSandbox* is set to true if needed
- []  Knowledge checks reviewed for spelling and accuracy

### Exercises
- [] All exercise units have *Exercise - * prefix on titles
