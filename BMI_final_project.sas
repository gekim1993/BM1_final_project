PROC Import datafile = "sas_train_data.csv" DBMS = CSV out = GH_data; GETNAMES = YES;
run;
proc contents data = GH_data;
run;

*forward automated selection;

PROC glm data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = is30dayreadmit mews cindex evisit ageyear gender race religion maritalstatus insurancetype bmi bpdiastolic bpsystolic heartrate o2sat respirationrate temperature;    
run;


PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = is30dayreadmit mews cindex is30dayreadmit evisit ageyear gender race religion maritalstatus insurancetype bmi bpdiastolic bpsystolic heartrate o2sat respirationrate temperature/ selection = forward(select = sl sle=0.15) stats = (adjrsq aic cp);    
run;

*backward automated selection;
PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = mews is30dayreadmit cindex evisit ageyear gender race religion maritalstatus insurancetype bmi bpdiastolic bpsystolic heartrate o2sat respirationrate temperature/ selection = backward(select = sl sls=0.15) stats = (adjrsq aic cp);    
run;

*stepwaise automated selection;
PROC glmselect data = GH_data;
class is30dayreadmit mews cindex gender religion race maritalstatus religion insurancetype;
model log_losdays2 = mews is30dayreadmit cindex evisit ageyear gender race religion maritalstatus insurancetype bmi bpdiastolic bpsystolic heartrate o2sat respirationrate temperature/ selection = stepwise(select = sl sle = .15 sls=0.15) stats = (adjrsq aic cp);    
run;


