function [output] = signalProcess2(rawDataArray,smoothingSpan)
%this function processes data by trimming time before zero, smoothing y values, then shifting the y values
%such that amplitude/2 is equal to zero.

%rawDataArray is both the x and y values of the raw data [x y]
%smoohing span is the mask length for the MATLAB function smooth, and must
%be an odd number

rawTime = rawDataArray(:,1); %extracting time from the data array
rawVoltage = rawDataArray(:,2); %extracting voltage from the data array

smoothedVoltage = smooth(rawVoltage,smoothingSpan); %smooths the voltage values

%Tlogic = rawTime>=0; %creates a logical array with 1 where time is greater that or equal to zero
%trimmedTime = rawTime(Tlogic); %trims the numerical array using the logical array
%trimmedTimeLength = length(trimmedTime);

%trimmedSmoothedVoltage = smoothedVoltage(end-trimmedTimeLength+1:end);


output = [rawTime smoothedVoltage];
end