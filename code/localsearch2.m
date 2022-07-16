function [ pop ] = localsearch2( pop,timewindow,dis,ser)
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
    for j=2:temp2    % 从第二个路线上的客户开始查找     插在当前点之前一直到最后一个0点为止
        temp=currentroute;
        temp=[temp(1:j-1) selectclient temp(j:end)];                  %第j个变成了这个新的
%       arrivetimenow=arrivetime(temp(j-1))+dis(temp(j-1)+1,temp(j)+1);
        [qingkuang,arrivetimetemp]=determine_feasible2(temp,timewindow,dis,arrivetime,ser);
         if qingkuang
            pop.arrivetime=arrivetimetemp;
            pop.cost(2)=pop.cost(2)-1;
            pop.cost(1)=pop.cost(1)-dis(temp(j-1)+1,temp(j+1)+1)-2*dis(1,temp(j)+1)+dis(temp(j-1)+1,temp(j)+1)+dis(temp(j)+1,temp(j+1)+1);
            finded=true;
            break
        end 
    end 
        
end
    


if finded
    newroute{i}=temp;
    for i=1:routenum-1
        newone=[newone,newroute{i}(2:end)];
    end
     
    pop.route=newone;
end

end