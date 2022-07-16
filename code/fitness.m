function [ fitness,arrivetime,route,rob] = fitness(pop,dis,varsize,demand,timewindow,capacity,ser)
fitness=[0;1];  %number of the vehicle is 1 at the first of the algorithm
arrivetime=zeros(1,varsize+1);
demandnow=0;
arrivetimenow=0;
% search=pop;
route=[0];
rob=0;
[~,routetemp]=sort(pop);
while ~isempty(routetemp)
    mm=1;
    count=min(15,length(routetemp));
    findclient=false;
    while mm<=count
        selectclient=routetemp(mm);
        arrivetimetemp=arrivetimenow+dis(selectclient+1,route(end)+1);
        if arrivetimetemp<timewindow(selectclient,2)
            if demand(routetemp)+demandnow<capacity
                route(end+1)=selectclient;
                arrivetimenow=max(timewindow(selectclient,1),arrivetimetemp);
%                 arrivetimenow=arrivetime+ser(selectvlient);           %gaigaigaigaigaigaigaiagiagai
                arrivetime(selectclient)=arrivetimenow;
                arrivetimenow=arrivetimenow+ser(selectclient);
                demandnow=demand(routetemp(mm))+demandnow;
                fitness(1)=fitness(1)+dis(route(end)+1,route(end-1)+1);
                jianju=(timewindow(selectclient,2)-timewindow(selectclient,1))/2;
                rob=rob+abs(arrivetime(selectclient)-(timewindow(selectclient,1)+jianju));
                routetemp(mm)=[];
                findclient=true;
                break
            else
                mm=mm+1;
            end
        else
            mm=mm+1;
        end
    end
    if ~findclient
        route(end+1)=0;
        arrivetimenow=0;
        fitness(1)=fitness(1)+dis(route(end)+1,route(end-1)+1);
        fitness(2)=fitness(2)+1;
        demandnow=0;
    end
end
    


fitness(1)=fitness(1)+dis(route(end)+1,1);
route(end+1)=0;
end