tic;
clc;
clear;



load('r1_type.mat');
customerloc=r10125(:,2:3);
depotloc=depot(2:3);
loc=[depotloc;customerloc];
demand=r10125(:,4);
timewindow=r10125(:,5:6);
ser=r10125(:,7);
capacity=200;
% load('customerloc.mat')
% load('demand.mat')
% load('depotloc.mat')
% load('timewindow.mat')
%% parameter setting
maxiter=50;   
maxiter2=50;
varmin=0;
varmax=1;
[varsize,~]=size(customerloc);
popsize=50;        
vmax=0.2;
vmin=-vmax;
c1=0.4;
c2=0.4;
w=0.8;
phi=2;
mutation=10;
ubmax=max(timewindow(:,2));
ubmin=min(timewindow(:,2));
%% optimal
dis=calculate_distance(customerloc,depotloc);

[PF,solutionarchive]=pso(maxiter,varmin,varmax,varsize,popsize,vmax,vmin,w,c1,c2,dis,demand,timewindow,capacity,mutation,ubmax,ubmin,ser);
%[PF,solutionarchive,normalx,normaly]=pso(maxiter,varmin,varmax,varsize,popsize,vmax,vmin,w,c1,c2,dis,demand,timewindow,capacity,mutation);
%% robust
PF=determine_feasible(PF,dis,timewindow,phi,ser);
PF=add_robustpopulation(PF,solutionarchive,dis,timewindow,phi,popsize,varsize,demand,capacity,maxiter2,w,c1,c2,vmin,vmax,varmin,varmax,ser);
% evaluation

tempcost=[PF.cost]';
[~,index]=unique(tempcost,'rows');
PF=PF(index);

rr=[];
for i=1:size(PF,1)
    [PF(i).robness,PF(i).extreme]=robustnesstest(PF(i),ser,timewindow,dis,phi);
    temp=[PF(i).cost]';
    temp=[temp,PF(i).robness,PF(i).extreme];
    rr=[rr;temp];
end
toc;



% lujing=PF(1).route;
% lujing=lujing+1;
% figure(1)
% text(depotloc(1),depotloc(2),'depot')
% 
% plot([loc(lujing,1);loc(lujing(1),1)],[loc(lujing,2);loc(lujing(1),2)],'o-')

