This directory contains csv files exported from the OOI UX database. These files
define the static structure of the ION system UI.

These files can be imported into the ION system as resource objects using the ion_loader tool.
Note: this tool can alternatively directly load export files from a web location.

The UX database is managed by the UX and architecture teams.

The default export location is:
  https://userexperience.oceanobservatories.org/database-exports/

To get the latest files manually, execute in this directory:
  wget -r -l1 -nd -nv -A.csv https://userexperience.oceanobservatories.org/database-exports/

If you don't have wget installed, get it with brew wget (on a Mac)
