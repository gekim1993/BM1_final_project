PROC Import datafile = "gh_project_data_no_na.csv" DBMS = CSV out = GH_data; GETNAMES = YES;
run;
proc contents data = GH_data;
run;

*forward automated selection;
PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = mews cindex evisit ageyear gender race religion maritalstatus insurancetype bmi/ selection = forward(select = sl sle=0.15) stats = (adjrsq aic cp);    
run;

*backward automated selection;
PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = mews cindex evisit ageyear gender race religion maritalstatus insurancetype bmi/ selection = backward(select = sl sls=0.15) stats = (adjrsq aic cp);    
run;

*stepwaise automated selection;
PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = mews cindex evisit ageyear gender race religion maritalstatus insurancetype bmi/ selection = stepwise(select = sl sle = .15 sls=0.15) stats = (adjrsq aic cp);    
run;
