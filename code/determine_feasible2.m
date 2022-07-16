function [ qingkuang,arrivetime ] = determine_feasible2( route,timewindow,dis,arrivetime,ser)
qingkuang=true;
arrivetimetemp=arrivetime;
arrivetimenow=0;
for i=1:length(route)-2        %第一个是一个被插入的 找到每一个对应客户的arrivetime以及更新arrivetime矩阵
    arrivetimenow=arrivetimenow+dis(route(i)+1,route(i+1)+1);
    if arrivetimenow>timewindow(route(i+1),2)
        qingkuang=false;
        break
    else
        arrivetimenow=max(timewindow(route(i+1),1),arrivetimenow);
        arrivetimetemp(route(i+1))=arrivetimenow;
        arrivetimenow=arrivetimenow+ser(route(i+1));
    end
end
if qingkuang
    arrivetime=arrivetimetemp;
end

end

