function [ pop ] = localsearch1( pop,timewindow,dis)
route=[pop.route];
select=find(route==0);
routenum=length(select)-1;
routeclient=zeros(routenum,1);
newroute=cell(routenum,1);
arrivetime=pop.arrivetime;
newone=[0];

finded=false;

for i=1:routenum
    newroute{i}=route(select(i):select(i+1));
    routeclient(i)=length(newroute{i});
end

[minnum,minclient]=min(routeclient);
if minnum(1)<4
    selectclient=newroute{minclient(1)}(end-1);
%     newroute{minclient}=[];
%     newroute{cellfun(@isempty,newroute)};              更先进的写法↓
    newroute(minclient(1))=[];
    i=randperm(routenum-1,1);
    currentroute=newroute{i};
    [~,temp2]=size(currentroute);
    for j=2:temp2-1    % 从第二个路线上的客户开始查找
        temp=currentroute;
        if timewindow(selectclient,2)<arrivetime(temp(j))
            temp=[temp(1:j-1) selectclient temp(j:end)];                  %第j个变成了这个新的
            arrivetimenow=arrivetime(temp(j-1))+dis(temp(j-1)+1,temp(j)+1);
            [qingkuang,arrivetimetemp]=determine_feasible2(temp(j:end-1),timewindow,dis,arrivetime,arrivetimenow);
            if qingkuang
                pop.arrivetime=arrivetimetemp;
                pop.cost(2)=pop.cost(2)-1;
                pop.cost(1)=pop.cost-dis(temp(j-1)+1,temp(j+1)+1)-2*dis(1,temp(j)+1)+dis(temp(j-1)+1,temp(j)+1)+dis(temp(j)+1,temp(j+1)+1);
                finded=true;
                break
            end 
        end               
    end
    if ~finded
        temp=currentroute;
        arrivetimenow=arrivetime+dis(selectclient+1,temp(j)+1);
        if arrivetimenow<timewindow(selectclient,2)
            temp=[temp(1:end-1) selectclient temp(end)];
            arrivetimenow=max(arrivetimenow,timewindow(selectclient,1));
            pop.arrivetime(selectclient)=arrivetimenow;
            pop.cost(2)=pop.cost(2)-1;
            pop.cost(1)=pop.cost(1)-dis(1,temp(j)+1)-dis(1,temp(end-2))+dis(temp(end-2)+1,temp(end-1)+1);
            finded=true;
        end
    end
    newroute{i}=temp;
end

if finded
     for i=1:routenum
            newone=[newone,newroute{i}(2:end)];
     end
     pop.route=newone;
end

end

