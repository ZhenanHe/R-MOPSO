function [ PF ] = add_robustpopulation( PF,solutionarchive,dis,timewindow,phi,popsize,varsize,demand,capacity,maxiter2,w,c1,c2,vmin,vmax,varmin,varmax,ser)
tempPF=PF;
PF=PF([PF.feasible]); 
pop=repmat(solutionarchive(1),popsize,1);
temp=determine_feasible(solutionarchive,dis,timewindow,phi,ser);
archive=temp([temp.feasible]); 
archive=DetermineDomination(archive);
newPF=archive(~[archive.IsDominated]);
archive=archive([archive.IsDominated]);
newPF=newPF([newPF.feasible]);                  
PF=[PF;newPF];                % 完成了对新的pareto解的更新


rob=[archive.rob];
[~,pos]=sort(rob);
archive=archive(pos);


tt=size(archive,1);
if tt> popsize
    pop=archive(1:popsize);
elseif tt==0
    for i=1:popsize
        pop(i).position=initial_variable( varmax,varmin,varsize);
        [pop(i).cost,pop(i).arrivetime,pop(i).route,pop(i).rob]=fitness(pop(i).position,dis,varsize,demand,timewindow,capacity,ser);
    end
	pop(tt:popsize)=determine_feasible(pop(tt:popsize),dis,timewindow,phi,ser);
else              
    pop(1:tt)=archive;
    for i=tt+1:popsize
        pop(i).position=initial_variable( varmax,varmin,varsize);
        [pop(i).cost,pop(i).arrivetime,pop(i).route,pop(i).rob]=fitness(pop(i).position,dis,varsize,demand,timewindow,capacity,ser);
    end
    pop(tt:popsize)=determine_feasible(pop(tt:popsize),dis,timewindow,phi,ser);
end
        
for i=1:popsize
    pop(i).pbest.cost=pop(i).cost;
    pop(i).pbest.position=pop(i).position;
    pop(i).pbest.rob=pop(i).rob;
    pop(i).pbest.feasible=pop(i).feasible;
    pop(i).velocity=rand(1,varsize);
end

if size(PF,1)>0
    zbest=selectzbest(PF);
else
    zbest=selectzbest(tempPF);
end

for i=1:maxiter2
    temparchive=[];
    for j=1:popsize
        tpop=pop(j);
        tpop.velocity=w*tpop.velocity+c1*rand*(tpop.pbest.position-tpop.position)+c2*(1-rand)*(zbest-tpop.position);
        tpop.velocity=max(tpop.velocity,vmin);
        tpop.velocity=min(tpop.velocity,vmax);
        tpop.position=tpop.position+tpop.velocity;
        tpop.position=max(tpop.position,varmin);
        tpop.position=min(tpop.position,varmax);
        [tpop.cost,tpop.arrivetime,tpop.route,tpop.rob]=fitness(tpop.position,dis,varsize,demand,timewindow,capacity,ser);
        tpop=determine_feasible( tpop,dis,timewindow,phi,ser);
        if tpop.feasible
            pop(j)=tpop;
            temparchive=[temparchive;pop(j)];
            if Dominates_2(pop(j),pop(j).pbest)         
                pop(j).pbest.cost=pop(j).cost;
                pop(j).pbest.posistion=pop(j).position;
                pop(j).pbest.rob=pop(j).rob;
                pop(j).pbest.feasible=pop(j).feasible;
            elseif Dominates_2(pop(j).pbest,pop(j))         
                if pop(j).pbest.rob>pop(j).rob
                    if rand()<0.3
                        pop(j).pbest.cost=pop(j).cost;
                        pop(j).pbest.posistion=pop(j).position;
                        pop(j).pbest.rob=pop(j).rob;
                        pop(j).pbest.feasible=pop(j).feasible;
                    end
                end
            else                                         
                if pop(j).pbest.rob>pop(j).rob
                    if rand()<0.3
                        pop(j).pbest.cost=pop(j).cost;
                        pop(j).pbest.posistion=pop(j).position; 
                        pop(j).pbest.rob=pop(j).rob;
                        pop(j).pbest.feasible=pop(j).feasible;
                    end
                end
            end
        end
        
        if rand<0.9
            tpop=pop(j);
            tpop=localsearch2(tpop,timewindow,dis,ser);
            tpop=determine_feasible(tpop,dis,timewindow,phi,ser);
            if size(tpop,1)~=0
                temp=tpop([tpop.feasible]);
%             if tpop.feasible
%                 temparchive=[temparchive;tpop];
%             end
                temparchive=[temparchive;temp];
            end
        end
    end
    temparchive=[temparchive;PF];
    temparchive=DetermineDomination2(temparchive);
    PF=temparchive(~[temparchive.IsDominated]);
    
                    
end
end








