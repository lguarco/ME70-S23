%{
Luisa Guarco 
ME70
Homework #1:  Calibration of sensors

The topics covered are all related to Matlab: 
   
%}
clear, clc
%% PART A: Analysis in MATLAB 
%{
Calibration of a temperature sensor. Testing of a prototype bi-metallic thermometer
results in calibration data (see link below), which includes a list of temperature points
(deg C) and corresponding deflection values (mm) for the metal pointer. Determine a
formula (linear approximation*) to convert the deflection values into degrees Celcius.  
%}

calibrationxx = load('NoisySaturationTempCalibrationData.mat', 'xx'); 
calibrationyy = load('NoisySaturationTempCalibrationData.mat', 'yy');

xx = calibrationxx.xx;
yy = calibrationyy.yy;

figure(1)
plot(yy, xx, 'bx');
title('Deflection vs Temperature');
xlabel('Temperature (C)');
ylabel('Deflection (mm)');

%Puts a range on the data from 0-100C
xx_range = xx(yy<100 & yy>0)';
yy_range = yy(yy<100 & yy>0)';

xxx = [xx_range, ones(length(xx_range), 1)];

%Regress to find a linear fit
[B, Bint, R] = regress(yy_range, xxx);

ymod = B(1)*(xx_range') +B(2);
xmod = xx_range;
 
hold on 
plot(ymod, xmod);

%{ 
As validation, examine the data from ice-bath to boiling water experiment (see link
below), which features deflection readings as a function of time. Convert the results to
temperature and plot the results. Explain your findings 
%}

%loading in the data
validationtt2 = load('HW1_waterboiling.mat', 'tt2');
validationyy2 = load('HW1_waterboiling.mat', 'yy2');

tt2 = validationtt2.tt2';
yy2 = validationyy2.yy2';

%Plots time as a function of deflection 
figure(2)
plot(tt2, yy2)
title('Deflection vs Time');
xlabel('Time (s)');
ylabel('Deflection (mm)');

%Calculates the temperature
temperature_validation = yy2*B(1) + B(2); 

figure(3) 
plot(tt2, temperature_validation, 'rx')
title('Temperature vs Time');
xlabel('Time (s)');
ylabel('Temperature (C)');


