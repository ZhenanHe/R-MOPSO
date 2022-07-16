function [ zbest,zbestcost ] = selectzbest( rep )

[maxm,~]=size(rep);
select=unidrnd(maxm);
zbest=rep(select).position;
zbestcost=rep(select).cost;

end

