function [ feasible ] = sample( routetemp,dis,timewindow,phi,ser)
feasible=true;
time=0;
for i=1:length(routetemp)-1
    if routetemp(i+1)==0
        time=0;
    else 
        time=time+dis(routetemp(i)+1,routetemp(i+1)+1)+phi*rand();
        if time>timewindow(routetemp(i+1),2)
            feasible=0;
            break
        else
            time=max(timewindow(routetemp(i+1),1),time);
            time=time+ser(routetemp(i+1));
        end
    end
end
 
end

