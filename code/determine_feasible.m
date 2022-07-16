function [PF ] = determine_feasible( PF,dis,timewindow,phi,ser)
[solutionnum,~]=size(PF);
for i=1:solutionnum
    routetemp=[PF(i).route];
    PF(i).feasible=true;
    for j=1:50
        feasible=sample(routetemp,dis,timewindow,phi,ser);
        if ~feasible
            PF(i).feasible=false;
            break
        end
    end
end



end

