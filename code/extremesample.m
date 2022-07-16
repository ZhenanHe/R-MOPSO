function [ robust ] = extremesample( routetemp,dis,timewindow,phi,ser)
time=0;
robust=0;
for i=1:length(routetemp)-1
    if routetemp(i+1)==0
        time=0;
    else 
        time=time+dis(routetemp(i)+1,routetemp(i+1)+1)+phi;
        robust=robust+max(0,time-timewindow(routetemp(i+1),2));
        time=max(timewindow(routetemp(i+1),1),time);
        time=time+ser(routetemp(i+1));
    end
end
 
end

