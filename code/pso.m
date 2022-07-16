function [ PF,archive ,normalx,normaly] = pso( maxiter,varmin,varmax,varsize,popsize,vmax,vmin,w,c1,c2,dis,demand,timewindow,capacity,mutation,ubmax,ubmin,ser)


empty.position=[];
empty.cost=[];
empty.velocity=[];
empty.IsDominated=[];
empty.arrivetime=[];
empty.route=[];
empty.pbest.position=[];
empty.pbest.cost=[];
empty.rob=[];
empty.feasible=[];

pop=repmat(empty,popsize,1);
popm=repmat(empty,mutation,1);
for i=1:popsize
    pop(i).position=initial_variable( varmax,varmin,varsize);
    pop(i).velocity=rand(1,varsize);
    [pop(i).cost,pop(i).arrivetime,pop(i).route,pop(i).rob]=fitness(pop(i).position,dis,varsize,demand,timewindow,capacity,ser);
    pop(i).pbest.position=pop(i).position;
    pop(i).pbest.cost=pop(i).cost;
    
end
archive=pop;
pop=DetermineDomination(pop);           
rep=pop(~[pop.IsDominated]); 
[zbest,~]=selectzbest(rep);

for i=1:maxiter
    for j=1:popsize
        
        pop(j).velocity=w*pop(j).velocity+c1*rand*(pop(j).pbest.position-pop(j).position)+c2*(1-rand)*(zbest-pop(j).position);
        pop(j).velocity=max(pop(j).velocity,vmin);
        pop(j).velocity=min(pop(j).velocity,vmax);
        pop(j).position=pop(j).position+pop(j).velocity;
        pop(j).position=max(pop(j).position,varmin);
        pop(j).position=min(pop(j).position,varmax);
        [pop(j).cost,pop(j).arrivetime,pop(j).route,pop(j).rob]=fitness(pop(j).position,dis,varsize,demand,timewindow,capacity,ser);
        archive=[archive;pop(j)];
        if Dominates(pop(j),pop(j).pbest)
            pop(j).pbest.cost=pop(j).cost;
            pop(j).pbest.posistion=pop(j).position;
        end                    %update the pbest
        
        
        if rand<0.5       %mutation
            pop(j).position=mu(pop(j).position,varsize,ubmax,ubmin,timewindow);
            [pop(j).cost,pop(j).arrivetime,pop(j).route,pop(j).rob]=fitness(pop(j).position,dis,varsize,demand,timewindow,capacity,ser);
            archive=[archive;pop(j)];
            if Dominates(pop(j),pop(j).pbest)
                pop(j).pbest.cost=pop(j).cost;
                pop(j).pbest.posistion=pop(j).position;
                pop(j).pbest.rob=pop(j).rob;
            elseif ~Dominates(pop(j).pbest,pop(j))
                if rand<0.5
                    pop(j).pbest.cost=pop(j).cost;
                    pop(j).pbest.posistion=pop(j).position;
                end
            end
        end
                      
    end
    
    temp=[pop;rep];
    temp=DetermineDomination(temp);           
    rep=temp(~[temp.IsDominated]); 
    [zbest,~]=selectzbest(rep);
end
PF=rep;
% [solutionnum,~]=size(archive);
% cost=[archive.cost];
% select=1:2:solutionnum;
% normalx=max(cost(select));
% cost(select)=[];
% normaly=max(cost);
end