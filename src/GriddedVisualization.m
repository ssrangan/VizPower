clear all; clc; close all;
tic;
% Load the topology of the grid
load('C:\Users\zqz\Desktop\Projects\2009 Jim Nutaro LDRD\Visualization\Experimental data\Case 1\MATLAB Format\Bus118Case.mat'); % Will load a structure called Bus
Frequency = load('C:\Users\zqz\Desktop\Grid Simulator\Generator #26 failed\_all_freq.dat');
t = Frequency(:,1);Numberoftimesteps = max(size(t));
Frequency = Frequency(:,2:119);

Frequency = (Frequency - min(Frequency(:))) ./ (max(Frequency(:))-min(Frequency(:)));
cLimLow = min(min(Frequency));
cLimHigh = max(max(Frequency));

NumberofGrids=100;
y = linspace(min(Bus.Latitude)-1,max(Bus.Latitude)+1,NumberofGrids);
x = linspace(min(Bus.Longitude)-1,max(Bus.Longitude)+1,NumberofGrids);
[X,Y] = meshgrid(x,y);


% Create distance-weighted matrix for each data point on the grid
kmlStr = [];S = 'yyyy-mm-ddTHH:MM:SSZ';
for t = 1:Numberoftimesteps
  Vi = gIDW(Bus.Longitude',Bus.Latitude',Frequency(t,:),X,Y,-5,'n',10);
  imagesc(Vi);pause(0.1);
  
%    tStart = datestr(t,S);
%    tStop = datestr(t+1,S);
%    kmlStr = [kmlStr, ge_surf(X,Y,Vi,'timeSpanStart',tStart,'timeSpanStop',tStop,'polyAlpha','AA','cLimLow',cLimLow,'cLimHigh',cLimHigh)];
end
% ge_output('CloudVisualization2.kml',kmlStr);
toc;



