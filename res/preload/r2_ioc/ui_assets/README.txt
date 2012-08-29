This directory contains csv files resulting from an export of the OOI UX database.
These files can be imported into the ION system as resource objects using the ion_loader tool.

The UX database is managed by the UX team and architecture team.

The default export location is:
  https://userexperience.oceanobservatories.org/database-exports/

To get the latest files manually, execute in this directory
  wget -r -l1 -nd -nv -A.csv https://userexperience.oceanobservatories.org/database-exports/

If you don't have wget installed, get it with brew wget (on a Mac)
