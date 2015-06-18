% This file will visualize the frequency oscillations as a quiver of arrows.

clear all; clc; close all;
% Load the topology of the grid
load('C:\Users\zqz\Desktop\Projects\2009 Jim Nutaro LDRD\Visualization\Experimental data\Case 1\MATLAB Format\Bus118Case.mat'); % Will load a structure called Bus
Frequency = load('C:\Users\zqz\Desktop\Grid Simulator\Generator #26 failed\_all_freq.dat');
Frequency = Frequency * 360; % Normalization factor for visualization purposes

% Load simulator results
Time = now; % I want to use the same start time for all the simulation - I got this number by using now command.
tic;

S = 'yyyy-mm-ddTHH:MM:SSZ';
kmlStr = [];

t = Frequency(:,1);Numberoftimesteps = max(size(t));
Frequency = Frequency(:,2:119);

for tt = 1:Numberoftimesteps
     tStart = datestr(Time + tt/(24*60*60),S);
     tEnd = datestr(Time +((tt+1)/(24*60*60)),S);            
        
   for i =1:118
%       ge_quiver(Bus(1).Longitude(i,1), Bus(1).Latitude(i,1), -20*cos(pi*Frequency(tt,i)/180),-20*sin(pi*Frequency(tt,i)/180),'lineColor','FFFFFFFF','lineWidth',1,'altitude',0,'timeSpanStart',tStart,'timeSpanStop',tEnd);   
        kmlStr = [kmlStr , ge_quiver(Bus(1).Longitude(i,1), Bus(1).Latitude(i,1), -20*cos(pi*Frequency(tt,i)/180),-20*sin(pi*Frequency(tt,i)/180),'lineColor','FFFFE600','lineWidth',4,'altitude',0,'timeSpanStart',tStart,'timeSpanStop',tEnd)];   
   end
end
    
ge_output('FrequencyOscillationsasArrows.kml',kmlStr);
toc;