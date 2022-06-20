%%------------------------------------------------------------------------%
% CANVAS Drag Assessment
% By Nicholas Hobar
% Importing data from AGI STK and ESA DRAMA
%%------------------------------------------------------------------------%

clc
clear
close all

%% -----------------------------------------------------------------------
%                              AGI STK Data
%-------------------------------------------------------------------------
%% Variable Definitions AREA
% Max Area (Y Ram) = 0.1332m^2
% Min Area (Z Ram) = 0.0142m^2
% X Ram Area = 0.0692m^2
% Avg Area = 0.092m^2
% Cd = 2.2
% Cr = 1.3
% Mass = 6kg
% 1976 Standard Astmospheric Density Model
% 2017 SolFlx_CSSI.dat
% J4Perturbation

maxAreaData = importdata('500km-maxArea-1976stnd.txt',' ',7);
minAreaData = importdata('500km-minArea-1976stnd.txt',' ',7);
avgAreaData = importdata('500km-avgArea-1976stnd.txt',' ',7);
xRamAreaData = importdata('500km-XramArea-1976stnd.txt',' ',7);

maxAreaApogee = maxAreaData.data(:,7);
maxAreaPerigee = maxAreaData.data(:,8);
maxAreaTime = strcat(maxAreaData.textdata(6:end,1),'-',maxAreaData.textdata(6:end,2),'-',maxAreaData.textdata(6:end,3));
maxAreaAlt = (maxAreaPerigee+maxAreaApogee)./2;

minAreaApogee = minAreaData.data(:,7);
minAreaPerigee = minAreaData.data(:,8);
minAreaTime = strcat(minAreaData.textdata(6:end,1),'-',minAreaData.textdata(6:end,2),'-',minAreaData.textdata(6:end,3));
minAreaAlt = (minAreaPerigee+minAreaApogee)./2;

avgAreaApogee = avgAreaData.data(:,7);
avgAreaPerigee = avgAreaData.data(:,8);
avgAreaTime = strcat(avgAreaData.textdata(6:end,1),'-',avgAreaData.textdata(6:end,2),'-',avgAreaData.textdata(6:end,3));
avgAreaAlt = (avgAreaPerigee+avgAreaApogee)./2;

xRamAreaApogee = xRamAreaData.data(:,7);
xRamAreaPerigee = xRamAreaData.data(:,8);
xRamAreaTime = strcat(xRamAreaData.textdata(6:end,1),'-',xRamAreaData.textdata(6:end,2),'-',xRamAreaData.textdata(6:end,3));
xRamAreaAlt = (xRamAreaPerigee+xRamAreaApogee)./2;

MaxAreaDuration = between(datetime(maxAreaTime(1)),datetime(maxAreaTime(end)))
MinAreaDuration = between(datetime(minAreaTime(1)),datetime(minAreaTime(end)))
AvgAreaDuration = between(datetime(avgAreaTime(1)),datetime(avgAreaTime(end)))
xRamAreaDuration = between(datetime(xRamAreaTime(1)),datetime(xRamAreaTime(end)))

%% Plots AREA

hold on
plot(datetime(maxAreaTime), maxAreaPerigee,'--')
plot(datetime(maxAreaTime), maxAreaApogee,'--')
plot(datetime(maxAreaTime), maxAreaAlt,'--')

plot(datetime(minAreaTime), minAreaPerigee,':')
plot(datetime(minAreaTime), minAreaApogee,':')
plot(datetime(minAreaTime), minAreaAlt,':')

plot(datetime(xRamAreaTime), xRamAreaPerigee,'-.')
plot(datetime(xRamAreaTime), xRamAreaApogee,'-.')
plot(datetime(xRamAreaTime), xRamAreaAlt,'-.')

plot(datetime(avgAreaTime), avgAreaPerigee)
plot(datetime(avgAreaTime), avgAreaApogee)
plot(datetime(avgAreaTime), avgAreaAlt)

xlabel('Date')
ylabel('Altitude (km)')
title('STK CANVAS Predicted Lifetime: Area Variance')
legend('0.1332m^2 (Y Ram) Area Perigee', '0.1332m^2 (Y Ram) Area Apogee','0.1332m^2 (Y Ram) Average Altitude',...
    '0.0142m^2 (Z Ram) Area Perigee','0.0142m^2 (Z Ram) Area Apogee','0.0142m^2 (Z Ram) Average Altitude',...
    '0.0692m^2 (X Ram) Area Perigee','0.0692m^2 (X Ram) Area Apogee','0.0692m^2 (X Ram) Average Altitude',...
    '0.092m^2 (Avg Area) Area Perigee','0.092m^2 (Avg Area) Area Apogee','0.092m^2 (Avg Area) Average Altitude')
hold off

figure(2)
hold on
plot(datetime(maxAreaTime), (maxAreaPerigee+maxAreaApogee)./2)
plot(datetime(minAreaTime), (minAreaPerigee+minAreaApogee)./2)
plot(datetime(xRamAreaTime), (xRamAreaPerigee+xRamAreaApogee)./2)
plot(datetime(avgAreaTime), (avgAreaPerigee+avgAreaApogee)./2)

xlabel('Date')
ylabel('Altitude (km)')
title('STK CANVAS Predicted Lifetime: Area Variance')
legend('0.1332m^2 (Y Ram) Average Altitude','0.017m^2 (Z Ram) Average Altitude',...
    '0.0692m^2 (X Ram) Average Altitude','0.092m^2 (Avg Area) Average Altitude')
hold off

%% Variable Definitions ATMOSPHERIC DENSITY
% Area Used = 0.092m^2
% Cd = 2.2
% Cr = 1.3
% Mass = 6kg
% 2017 SolFlx_CSSI.dat

Stnd1976Data = importdata('500km-avgArea-1976stnd.txt',' ',7);
CIRA1972Data = importdata('500km-avgArea-CIRA1972.txt',' ',7);
HarrisPreisterData = importdata('500km-avgArea-HarrisPreister.txt',' ',7);
Jacchia1971Data = importdata('500km-avgArea-Jacchia1971.txt',' ',7);
JacchiaRobertsData = importdata('500km-avgArea-JacchiaRoberts.txt',' ',7);
NRLMSISE2000Data = importdata('500km-avgArea-NRLMSISE2000.txt',' ',7);

Stnd1976Apogee = Stnd1976Data.data(:,7);
Stnd1976Perigee = Stnd1976Data.data(:,8);
Stnd1976Time = strcat(Stnd1976Data.textdata(6:end,1),'-',Stnd1976Data.textdata(6:end,2),'-',Stnd1976Data.textdata(6:end,3));

CIRA1972Apogee = CIRA1972Data.data(:,7);
CIRA1972Perigee = CIRA1972Data.data(:,8);
CIRA1972Time = strcat(CIRA1972Data.textdata(6:end,1),'-',CIRA1972Data.textdata(6:end,2),'-',CIRA1972Data.textdata(6:end,3));

HarrisPreisterApogee = HarrisPreisterData.data(:,7);
HarrisPreisterPerigee = HarrisPreisterData.data(:,8);
HarrisPreisterTime = strcat(HarrisPreisterData.textdata(6:end,1),'-',HarrisPreisterData.textdata(6:end,2),'-',HarrisPreisterData.textdata(6:end,3));

Jacchia1971Apogee = Jacchia1971Data.data(:,7);
Jacchia1971Perigee = Jacchia1971Data.data(:,8);
Jacchia1971Time = strcat(Jacchia1971Data.textdata(6:end,1),'-',Jacchia1971Data.textdata(6:end,2),'-',Jacchia1971Data.textdata(6:end,3));

JacchiaRobertsApogee = JacchiaRobertsData.data(:,7);
JacchiaRobertsPerigee = JacchiaRobertsData.data(:,8);
JacchiaRobertsTime = strcat(JacchiaRobertsData.textdata(6:end,1),'-',JacchiaRobertsData.textdata(6:end,2),'-',JacchiaRobertsData.textdata(6:end,3));

NRLMSISE2000Apogee = NRLMSISE2000Data.data(:,7);
NRLMSISE2000Perigee = NRLMSISE2000Data.data(:,8);
NRLMSISE2000Time = strcat(NRLMSISE2000Data.textdata(6:end,1),'-',NRLMSISE2000Data.textdata(6:end,2),'-',NRLMSISE2000Data.textdata(6:end,3));

Stnd1976Duration = between(datetime(Stnd1976Time(1)),datetime(Stnd1976Time(end)))
CIRA1972Duration = between(datetime(CIRA1972Time(1)),datetime(CIRA1972Time(end)))
HarrisPreisterDuration = between(datetime(HarrisPreisterTime(1)),datetime(HarrisPreisterTime(end)))
Jacchia1971Duration = between(datetime(Jacchia1971Time(1)),datetime(Jacchia1971Time(end)))
JacchiaRobertsDuration = between(datetime(JacchiaRobertsTime(1)),datetime(JacchiaRobertsTime(end)))
NRLMSISE2000Duration = between(datetime(NRLMSISE2000Time(1)),datetime(NRLMSISE2000Time(end)))

%% Plots ATMOSPHERIC DENSITY

figure(3)
hold on
plot(datetime(Stnd1976Time), Stnd1976Perigee,'--')
plot(datetime(Stnd1976Time), Stnd1976Apogee,'--')
plot(datetime(Stnd1976Time), (Stnd1976Perigee+Stnd1976Apogee)./2,'--')

plot(datetime(CIRA1972Time), CIRA1972Perigee,':')
plot(datetime(CIRA1972Time), CIRA1972Apogee,':')
plot(datetime(CIRA1972Time), (CIRA1972Perigee+CIRA1972Apogee)./2,':')

plot(datetime(HarrisPreisterTime), HarrisPreisterPerigee)
plot(datetime(HarrisPreisterTime), HarrisPreisterApogee)
plot(datetime(HarrisPreisterTime), (HarrisPreisterPerigee+HarrisPreisterApogee)./2)

plot(datetime(Jacchia1971Time), Jacchia1971Perigee,'-.')
plot(datetime(Jacchia1971Time), Jacchia1971Apogee,'-.')
plot(datetime(Jacchia1971Time), (Jacchia1971Perigee+Jacchia1971Apogee)./2,'-.')

plot(datetime(JacchiaRobertsTime), JacchiaRobertsPerigee,'.')
plot(datetime(JacchiaRobertsTime), JacchiaRobertsApogee,'.')
plot(datetime(JacchiaRobertsTime), (JacchiaRobertsPerigee+JacchiaRobertsApogee)./2,'.')

plot(datetime(NRLMSISE2000Time), NRLMSISE2000Perigee)
plot(datetime(NRLMSISE2000Time), NRLMSISE2000Apogee)
plot(datetime(NRLMSISE2000Time), (NRLMSISE2000Perigee+NRLMSISE2000Apogee)./2)

hold off

xlabel('Date')
ylabel('Altitude (km)')
title('STK CANVAS Predicted Lifetime: Atmospheric Density Model Variance')
legend('1976 Standard Perigee', '1976 Standard Apogee', '1976 Standard Average Altitude',...
    'CIRA 1972 Perigee', 'CIRA 1972 Apogee', 'CIRA 1972 Average Altitude',...
    'Harris Preister Perigee', 'Harris Preister Apogee', 'Harris Preister Average Altitude',...
    'Jacchia 1971 Perigee', 'Jacchia 1971 Apogee', 'Jacchia 1971 Average Altitude',...
    'Jacchia Roberts Perigee', 'Jacchia Roberts Apogee', 'Jacchia Roberts Average Altitude',...
    'NRLMSISE2000 Perigee', 'NRLMSISE2000 Apogee', 'NRLMSISE2000 Average Altitude')

figure(4)
hold on
plot(datetime(Stnd1976Time), (Stnd1976Perigee+Stnd1976Apogee)./2,'--')
plot(datetime(CIRA1972Time), (CIRA1972Perigee+CIRA1972Apogee)./2,':')
plot(datetime(HarrisPreisterTime), (HarrisPreisterPerigee+HarrisPreisterApogee)./2)
plot(datetime(Jacchia1971Time), (Jacchia1971Perigee+Jacchia1971Apogee)./2,'-.')
plot(datetime(JacchiaRobertsTime), (JacchiaRobertsPerigee+JacchiaRobertsApogee)./2,'.')
plot(datetime(NRLMSISE2000Time), (NRLMSISE2000Perigee+NRLMSISE2000Apogee)./2)

xlabel('Date')
ylabel('Altitude (km)')
title('STK CANVAS Predicted Lifetime: Atmospheric Density Model Variance')
legend('1976 Standard Average Altitude',...
    'CIRA 1972 Average Altitude',...
    'Harris Preister Average Altitude',...
    'Jacchia 1971 Average Altitude',...
    'Jacchia Roberts Average Altitude',...
    'NRLMSISE2000 Average Altitude')
hold off

%% -----------------------------------------------------------------------
%                              ESA DRAMA Data
%-------------------------------------------------------------------------
%% DRAMA Variable Definitions AREA
% Max Area (Y Ram) = 0.1332m^2
% Min Area (Z Ram) = 0.0142m^2
% X Ram Area = 0.0692m^2
% Avg Area = 0.092m^2
% Cd = 2.2
% Cr = 1.3
% Mass = 6kg
% Starting Altitude = 500km (6878km semi-major axis)
% Eccentricity = 1.0E-4
% Inclincation = 51.6 deg
% Latest ESA Solar & Geomagnetic Data

D_maxAreaData = importdata('DRAMA-500km-maxArea.txt',' ',53);
D_minAreaData = importdata('DRAMA-500km-minArea.txt',' ',53);
D_avgAreaData = importdata('DRAMA-500km-avgArea.txt',' ',53);
D_xRamAreaData = importdata('Drama-500km-XramArea.txt',' ',53);

D_maxAreaAlt = D_maxAreaData.data(:,2);
D_minAreaAlt = D_minAreaData.data(:,2);
D_avgAreaAlt = D_avgAreaData.data(:,2);
D_xRamAreaAlt = D_xRamAreaData.data(:,2);

D_maxAreaTime = strcat(D_maxAreaData.textdata(54:end,1));
D_minAreaTime = strcat(D_minAreaData.textdata(54:end,1));
D_avgAreaTime = strcat(D_avgAreaData.textdata(54:end,1));
D_xRamAreaTime = strcat(D_xRamAreaData.textdata(54:end,1));

D_MaxAreaDuration = between(datetime(D_maxAreaTime(1)),datetime(D_maxAreaTime(end)))
D_MinAreaDuration = between(datetime(D_minAreaTime(1)),datetime(D_minAreaTime(end)))
D_AvgAreaDuration = between(datetime(D_avgAreaTime(1)),datetime(D_avgAreaTime(end)))
D_xRamAreaDuration = between(datetime(D_xRamAreaTime(1)),datetime(D_xRamAreaTime(end)))

%% DRAMA Plots AREA

figure(5)
hold on
plot(datetime(D_maxAreaTime), D_maxAreaAlt-6378)
plot(datetime(D_minAreaTime), D_minAreaAlt-6378)
plot(datetime(D_xRamAreaTime), D_xRamAreaAlt-6378)
plot(datetime(D_avgAreaTime), D_avgAreaAlt-6378)

xlabel('Date')
ylabel('Altitude (km)')
title('DRAMA CANVAS Predicted Lifetime: Area Variance')
legend('0.1332m^2 (Y Ram) Area','0.0142m^2 (Z Ram) Area','0.0692m^2 (X Ram) Area','0.092m^2 Avg Ram Area')
hold off

%% DRAMA Variable Definitions SOLAR & GEOMAGNETIC ACTIVITY
% SF_CONST = 146.4749 - Constant solar flux level [sfu] 15.0000 - Constant Ap level

SF_OE = importdata('DRAMA-500km-avgArea-SF-OE.txt',' ',54);
SF_OEW = importdata('DRAMA-500km-avgArea-SF-OEW.txt',' ',54);
SF_OEB = importdata('DRAMA-500km-avgArea-SF-OEB.txt',' ',54);
SF_CONST = importdata('DRAMA-500km-avgArea-SF-CONST.txt',' ',55);
SF_ECSS = importdata('DRAMA-500km-avgArea-SF-ECSS.txt',' ',54);
SF_MC = importdata('DRAMA-500km-avgArea-SF-MC.txt',' ',54);

SF_OE_Alt = SF_OE.data(:,2);
SF_OEW_Alt = SF_OEW.data(:,2);
SF_OEB_Alt = SF_OEB.data(:,2);
SF_CONST_Alt = SF_CONST.data(:,2);
SF_ECSS_Alt = SF_ECSS.data(:,2);
SF_MC_Alt = SF_MC.data(:,2);

SF_OE_Time = strcat(SF_OE.textdata(55:end,1));
SF_OEW_Time = strcat(SF_OEW.textdata(55:end,1));
SF_OEB_Time = strcat(SF_OEB.textdata(55:end,1));
SF_CONST_Time = strcat(SF_CONST.textdata(56:end,1));
SF_ECSS_Time = strcat(SF_ECSS.textdata(55:end,1));
SF_MC_Time = strcat(SF_MC.textdata(55:end,1));

SF_OE_Duration = between(datetime(SF_OE_Time(1)),datetime(SF_OE_Time(end)))
SF_OEW_Duration = between(datetime(SF_OEW_Time(1)),datetime(SF_OEW_Time(end)))
SF_OEB_Duration = between(datetime(SF_OEB_Time(1)),datetime(SF_OEB_Time(end)))
SF_CONST_Duration = between(datetime(SF_CONST_Time(1)),datetime(SF_CONST_Time(end)))
SF_ECSS_Duration = between(datetime(SF_ECSS_Time(1)),datetime(SF_ECSS_Time(end)))
SF_MC_Duration = between(datetime(SF_MC_Time(1)),datetime(SF_MC_Time(end)))

%% DRAMA Plots SOLAR & GEOMAGNETIC ACTIVITY

figure (6)
hold on
plot(datetime(SF_OE_Time),SF_OE_Alt-6378)
plot(datetime(SF_OEW_Time),SF_OEW_Alt-6378)
plot(datetime(SF_OEB_Time),SF_OEB_Alt-6378)
plot(datetime(SF_CONST_Time),SF_CONST_Alt-6378)
plot(datetime(SF_ECSS_Time),SF_ECSS_Alt-6378)
plot(datetime(SF_MC_Time),SF_MC_Alt-6378)

xlabel('Date')
ylabel('Altitude (km)')
title('DRAMA CANVAS Predicted Lifetime: Solar & Geomagnetic Activity Variance')
legend('Latest ESA Prediction','Worst Case (+50% CI)','Best Case (-50% CI)','Constant SF (146.4749 sfu)','ECSS SF (23rd SC)','Monte Carlo SF (5 SCs)')
hold off


%% -----------------------------------------------------------------------
%                              Data Synthesis
%-------------------------------------------------------------------------
%% STK and DRAMA Combined Plots

figure(7)
hold on
plot(datetime(maxAreaTime), (maxAreaPerigee+maxAreaApogee)./2,'--')
plot(datetime(minAreaTime), (minAreaPerigee+minAreaApogee)./2,'--')
plot(datetime(xRamAreaTime), (xRamAreaPerigee+xRamAreaApogee)./2,'--')
plot(datetime(avgAreaTime), (avgAreaPerigee+avgAreaApogee)./2,'--')
plot(datetime(D_maxAreaTime), D_maxAreaAlt-6378)
plot(datetime(D_minAreaTime), D_minAreaAlt-6378)
plot(datetime(D_xRamAreaTime), D_xRamAreaAlt-6378)
plot(datetime(D_avgAreaTime), D_avgAreaAlt-6378)

xlabel('Date')
ylabel('Altitude (km)')
title('DRAMA vs. STK in Area Variance')
legend('STK Max Area','STK Min Area','STK X Ram Area','STK Avg Area',...
    'DRAMA Max Area','DRAMA Min Area','DRAMA X Ram Area','DRAMA Avg Area')
hold off

%% DRAMA Absolute Min/Max Lifetime

D_maxArea_MCSF = importdata('DRAMA-500km-maxArea-MCSF.txt',' ',54);
D_minArea_WCSF = importdata('DRAMA-500km-minArea-WCSF.txt',' ',54);

D_maxArea_MCSF_Alt = D_maxArea_MCSF.data(:,2);
D_minArea_WCSF_Alt = D_minArea_WCSF.data(:,2);

D_maxArea_MCSF_Time = strcat(D_maxArea_MCSF.textdata(55:end,1));
D_minArea_WCSF_Time = strcat(D_minArea_WCSF.textdata(55:end,1));

D_maxArea_MCSF_Duration = between(datetime(D_maxArea_MCSF_Time(1)),datetime(D_maxArea_MCSF_Time(end)))
D_minArea_WCSF_Duration = between(datetime(D_minArea_WCSF_Time(1)),datetime(D_minArea_WCSF_Time(end)))

figure(8)
hold on
plot(datetime(D_maxArea_MCSF_Time), D_maxArea_MCSF_Alt-6378)
plot(datetime(D_minArea_WCSF_Time), D_minArea_WCSF_Alt-6378)
plot(datetime(D_avgAreaTime), D_avgAreaAlt-6378)

xlabel('Date')
ylabel('Altitude (km)')
title('DRAMA Absolute Minumum and Maximum Lifetimes')
legend('Max Area/MC SF','Min Area/WC SF','Avg Area/Latest ESA Prediction SF')
hold off

%% DRAMA Likely Lifetime with a Worst Case Solar Flux and Avg Area

figure(9)
hold on
plot(datetime(SF_MC_Time),SF_MC_Alt-6378,'-o','MarkerIndices',[1 11 18 25 29 32 36 40 43])

xlabel('Date')
ylabel('Altitude (km)')
title('DRAMA Monte Carlo Solar Flux (Lowest Lifetime) with Average Area')
hold off

%% STK Abolsute Min/Max Lifetime

maxArea_JacchiaRoberts = importdata('500km-maxArea-JacchiaRoberts.txt',' ',7);
minArea_HarrisPreister = importdata('500km-minArea-HarrisPreister.txt',' ',7);

maxArea_JacchiaRoberts_Apogee = maxArea_JacchiaRoberts.data(:,7);
maxArea_JacchiaRoberts_Perigee = maxArea_JacchiaRoberts.data(:,8);
maxArea_JacchiaRoberts_Time = strcat(maxArea_JacchiaRoberts.textdata(6:end,1),'-',...
    maxArea_JacchiaRoberts.textdata(6:end,2),'-',maxArea_JacchiaRoberts.textdata(6:end,3));

minArea_HarrisPreister_Apogee = minArea_HarrisPreister.data(:,7);
minArea_HarrisPreister_Perigee = minArea_HarrisPreister.data(:,8);
minArea_HarrisPreister_Time = strcat(minArea_HarrisPreister.textdata(6:end,1),'-',...
    minArea_HarrisPreister.textdata(6:end,2),'-',minArea_HarrisPreister.textdata(6:end,3));

maxArea_JacchiaRoberts_Duration = between(datetime(maxArea_JacchiaRoberts_Time(1)),datetime(maxArea_JacchiaRoberts_Time(end)))
minArea_HarrisPreister_Duration = between(datetime(minArea_HarrisPreister_Time(1)),datetime(minArea_HarrisPreister_Time(end)))

figure(10)
hold on
plot(datetime(maxArea_JacchiaRoberts_Time), (maxArea_JacchiaRoberts_Apogee+maxArea_JacchiaRoberts_Perigee)./2)
plot(datetime(minArea_HarrisPreister_Time), (minArea_HarrisPreister_Apogee+minArea_HarrisPreister_Perigee)./2)
plot(datetime(avgAreaTime), avgAreaAlt)

xlabel('Date')
ylabel('Altitude (km)')
title('STK Absolute Minumum and Maximum Lifetimes')
legend('Max Area/Jacchia Roberts Atmo','Min Area/Harris Preister Atmo','Avg Area/1976 Standard Atmo')
hold off

%% STK Likely Lifetime with Worst Case Atmosphere Model and Average Area

figure(11)
hold on
plot(datetime(JacchiaRobertsTime), (JacchiaRobertsPerigee+JacchiaRobertsApogee)./2,...
    '-o','MarkerIndices',[1 216 398 504 592 680 746 804 864])

xlabel('Date')
ylabel('Altitude (km)')
title('STK Jacchia Roberts Atmosphere Model (Lowest Lifetime Atmo) with Average Area')
hold off

%% STK and DRAMA Combined Absolute Min/Max Lifetimes

figure(12)
hold on
plot(datetime(maxArea_JacchiaRoberts_Time), (maxArea_JacchiaRoberts_Apogee+maxArea_JacchiaRoberts_Perigee)./2)
plot(datetime(minArea_HarrisPreister_Time), (minArea_HarrisPreister_Apogee+minArea_HarrisPreister_Perigee)./2)
plot(datetime(D_maxArea_MCSF_Time), D_maxArea_MCSF_Alt-6378)
plot(datetime(D_minArea_WCSF_Time), D_minArea_WCSF_Alt-6378)

xlabel('Date')
ylabel('Altitude (km)')
title('STK and DRAMA Min/Max Lifetimes')
legend('Max Area/Jacchia Roberts Atmo','Min Area/Harris Preister Atmo','Max Area/Monte Carlo SF','Min Area/WCSF')
hold off

%% STK and DRAMA Combined with Avg Atmo/SF/Area

D_8kg_LatestSF = importdata('DRAMA-8kg-LatestSF-AvgArea.txt',' ',54);
STK_8kg_1976Stnd = importdata('STK-8kg-1976Stnd.txt',' ',7);

D_8kg_LatestSF_Alt = D_8kg_LatestSF.data(:,2);
STK_8kg_1976Stnd_Apogee = STK_8kg_1976Stnd.data(:,7);
STK_8kg_1976Stnd_Perigee = STK_8kg_1976Stnd.data(:,8);
STK_8kg_1976Stnd_Alt = (STK_8kg_1976Stnd_Apogee + STK_8kg_1976Stnd_Perigee)./2;

D_8kg_LatestSF_Time = strcat(D_8kg_LatestSF.textdata(55:end,1));
STK_8kg_1976Stnd_Time = strcat(STK_8kg_1976Stnd.textdata(6:end,1),'-',...
    STK_8kg_1976Stnd.textdata(6:end,2),'-',STK_8kg_1976Stnd.textdata(6:end,3));

D_8kg_LatestSF_Duration = between(datetime(D_8kg_LatestSF_Time(1)),datetime(D_8kg_LatestSF_Time(end)))
STK_8kg_1976Stnd_Duration = between(datetime(STK_8kg_1976Stnd_Time(1)),datetime(STK_8kg_1976Stnd_Time(end)))

figure(13)
hold on
plot(datetime(D_8kg_LatestSF_Time), D_8kg_LatestSF_Alt-6378,...
    '-o','MarkerIndices',[1 31 60 79 98 113 128 138 145 152 158])
plot(datetime(STK_8kg_1976Stnd_Time), STK_8kg_1976Stnd_Alt,...
    '-o','MarkerIndices',[1 256 465 643 792 919 1029 1121 1199 1266 1323])

xlabel('Date')
ylabel('Altitude (km)')
title('CANVAS STK and DRAMA Avg Area/Avg SF Lifetime at 8kg')
legend('DRAMA Data with Latest ESA SF Predict','STK Data with Avg Atmo Model')
hold off

%% Average Area, Average Atmo Model, Average Solar Flux

figure(14)
hold on
plot(datetime(Stnd1976Time), (Stnd1976Perigee+Stnd1976Apogee)./2,...
    '-o','MarkerIndices',[1 193 353 487 600 698 779 851 910 961 1005])
plot(datetime(D_avgAreaTime), D_avgAreaAlt-6378,...
    '-o','MarkerIndices',[1 25 46 64 75 88 97 104 111 118 125])

xlabel('Date')
ylabel('Altitude (km)')
title('STK and DRAMA Lifetime with Average Area/Atmo/Solar Flux')
legend('STK Data with Average Atmospheric Model','DRAMA Data with Average Solar Flux')
hold off