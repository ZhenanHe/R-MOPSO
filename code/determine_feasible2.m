function [ qingkuang,arrivetime ] = determine_feasible2( route,timewindow,dis,arrivetime,ser)
qingkuang=true;
arrivetimetemp=arrivetime;
arrivetimenow=0;
for i=1:length(route)-2        %��һ����һ��������� �ҵ�ÿһ����Ӧ�ͻ���arrivetime�Լ�����arrivetime����
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

