clear all; clc; close all;
% Load the topology of the grid
load('C:\Users\zqz\Desktop\Projects\2009 Jim Nutaro LDRD\Visualization\Experimental data\Case 1\MATLAB Format\Bus118Case.mat'); % Will load a structure called Bus

% Load simulator results
Time = 7.343546339707176e+005; % I want to use the same start time for all the simulation - I got this number by using now command.

tic;
% Load the simulator files
Voltage = load('C:\Users\zqz\Desktop\Grid Simulator\IEEE 118 Case\Jims Simulation Results\Generator #25 failed\_all_volts.dat');
Frequency = load('C:\Users\zqz\Desktop\Grid Simulator\IEEE 118 Case\Jims Simulation Results\Generator #25 failed\_all_freq.dat');
Phase = load('C:\Users\zqz\Desktop\Grid Simulator\IEEE 118 Case\Jims Simulation Results\Generator #25 failed\_all_angles.dat');


% Separate time and Data
t = Frequency(:,1);Numberoftimesteps = max(size(t));
Frequency = Frequency(:,2:119);Voltage = Voltage(:,2:119); Phase = Phase(:,2:119);
% figure(1); plot(t,Frequency); figure(2); plot(t,Voltage); figure(3); plot(t, Phase);

% Some KML specific parameters initialized
kmlStrFreq = [];kmlStrVoltage = [];kmlStrPhase = [];S = 'yyyy-mm-ddTHH:MM:SSZ';

for tt =1:Numberoftimesteps
    tt
    tStart = datestr(Time+ ((tt)/(24*60*60)),S);
    tEnd = datestr(Time+((tt+1)/(24*60*60)),S);            
    
    for i =1:118

        % Frequency as circles
        
        if(Frequency(tt,i) > 0)
             kmlStrFreq = [kmlStrFreq, ge_circle(Bus.Longitude(i),Bus.Latitude(i),25000*abs(Frequency(tt,i))*3,'divisions',5,'timeSpanStart',tStart,'timeSpanStop',tEnd, 'polyColor','AA0000FF','lineColor','FF0000FF')];          
        else
             kmlStrFreq = [kmlStrFreq, ge_circle(Bus.Longitude(i),Bus.Latitude(i),25000*abs(Frequency(tt,i))*3,'divisions',5,'timeSpanStart',tStart,'timeSpanStop',tEnd, 'polyColor','AAFF0000','lineColor','FFFF0000')];          
        end
     
%         % Phase angles as arrows
         kmlStrPhase = [kmlStrPhase , ge_quiver(Bus(1).Longitude(i,1), Bus(1).Latitude(i,1), -20*cos(pi*Phase(tt,i)/180),-20*sin(pi*Phase(tt,i)/180),'lineColor','FFFFFFFF','lineWidth',1,'altitude',0,'timeSpanStart',tStart,'timeSpanStop',tEnd)];   
        
        % Voltages as boxes
        BoxSize = 0.05*Voltage(tt,i);
        ColorString = 'AA00FF00';
%         if abs(Voltage(tt,i)) < 0.6 
%             BoxSize = 0.05*Voltage(tt,i); ColorString = 'AA0000FF';
%         end
        if abs(Voltage(tt,i)) < 0.95 
            BoxSize = 0.05*Voltage(tt,i); ColorString = 'AAFF0000';
        end
        if abs(Voltage(tt,i)) > 1.05 
            BoxSize = 0.05*Voltage(tt,i); ColorString = 'AA0000FF';
        end
        
        kmlStrVoltage = [kmlStrVoltage, ge_box(Bus(1).Longitude(i,1)-BoxSize,Bus(1).Longitude(i,1)+BoxSize,Bus(1).Latitude(i,1)-BoxSize,Bus(1).Latitude(i,1)+BoxSize,'lineColor','FF000000','polyColor',ColorString,'timeSpanStart',tStart,'timeSpanStop',tEnd)];            
     end
end

ge_output('Voltage.kml',kmlStrVoltage);
ge_output('Frequency.kml',kmlStrFreq);
ge_output('PhaseAngle.kml',kmlStrPhase);

toc;