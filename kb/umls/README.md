Granting privileges to the 'postgres' user for exploring and reading is required to populate the database.

During experiments, some rows from the RFF files returned errors of insufficient data, which stops the population pipeline altogether. That's because of an unfortunate character combination of "\|", that truncates its purpose as a attribute separator. In the future, a preprocessing pipeline to replace the error triggers should be performed for all interesting tables for seamless population.
