function [ fitness,arrivetime,route,rob] = fitness2(pop,dis,varsize,demand,timewindow,capacity)
fitness=[0,1];  %number of the vehicle is 1 at the first of the algorithm
arrivetime=zeros(1,varsize+1);
demandnow=0;
arrivetimenow=0;
search=pop;
route=[0];
rob=0;
while ~isempty(pop)
    [value,select]=min(pop);
    selectclient=find(search==value);
    selectclient=selectclient(1);
    
    if demandnow+demand(selectclient)>capacity
        arrivetimenow=0;
        route(end+1)=0;
        demandnow=0;
        fitness(2)=fitness(2)+1;
    end
    
    arrivetimetemp=arrivetimenow+dis(route(end)+1,selectclient+1);
    if arrivetimetemp>timewindow(selectclient,2)
        arrivetimenow=0;
        route(end+1)=0;
        fitness(1)=fitness(1)+dis(route(end)+1,route(end-1)+1);
        demandnow=0;
        fitness(2)=fitness(2)+1;
        arrivetimetemp=arrivetimenow+dis(route(end)+1,selectclient+1);
    end
    arrivetimenow=max(timewindow(selectclient,1),arrivetimetemp);
    arrivetime(selectclient)=arrivetimenow;
    jianju=(timewindow(selectclient,2)-timewindow(selectclient,1))/2;
    rob=rob+abs(arrivetime(selectclient)-(timewindow(selectclient,1)+jianju));
    route(end+1)=selectclient;
    demandnow=demand(selectclient)+demandnow;
    fitness(1)=fitness(1)+dis(route(end)+1,route(end-1)+1);
    pop(select(1))=[];
end
fitness(1)=fitness(1)+dis(route(end)+1,1);
route(end+1)=0;
end