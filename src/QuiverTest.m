clear all; clc;
S = 'yyyy-mm-ddTHH:MM:SSZ';
Time = now;

kmlStr = [];
for t = 1:10
     tStart = datestr(Time+ ((t)/(24*60*60)),S)
     tEnd = datestr(Time+((t+1)/(24*60*60)),S)      
    
%     tStart = datestr(t,S)
%     tEnd = datestr(t+1,S)      


    kmlStr = [kmlStr, ge_quiver(-83.33, 35.60,-10*cos(pi*t/180),-10*sin(pi*t/180),'lineColor','FFFFFFFF','lineWidth',1,'altitude',0,'timeSpanStart',tStart,'timeSpanStop',tEnd)];     
end
    
ge_output('QuiverTesttry.kml',kmlStr)