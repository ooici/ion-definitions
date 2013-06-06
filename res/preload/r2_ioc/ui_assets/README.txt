This directory contains csv files exported from the OOI UX database. These files
define the static structure of the ION system UI.

These files can be imported into the ION system as resource objects using the ion_loader tool.
Note: this tool can alternatively directly load export files from a web location.

The UX database is managed by the UX and architecture teams.

The known export locations are:
  https://userexperience.oceanobservatories.org/database-exports/Stable
  https://userexperience.oceanobservatories.org/database-exports/Candidates

To get the latest files manually, execute in this directory:
  wget -r -l1 -nd -nv -A.csv https://userexperience.oceanobservatories.org/database-exports/Candidates

If you don't have wget installed, get it with brew wget (on a Mac)


To be able to grep CSV files, the need to be converted to Mac newlines:
  brew install dos2unix
  dos2unix -f -l *.csv
  grep instruments_operational _jt_ScreenElement_ScreenElement.csv
