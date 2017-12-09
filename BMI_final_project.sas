PROC Import datafile = "gh_project_data.csv" DBMS = CSV out = GH_data; GETNAMES = YES;
run;
proc contents data = GH_data;
run;

PROC REG data = GH_data;
model / slentry = 0.15 slstay = 0.15
selection = forward;
run;

PROC REG data = GH_data;
model / slentry = 0.15 slstay = 0.15
selection = backward;
run;

PROC REG data = GH_datan;
model / slentry = 0.15 slstay = 0.15
selection = stepwise;
run;
