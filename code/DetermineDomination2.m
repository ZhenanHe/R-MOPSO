function pop=DetermineDomination2(pop)

    nPop=numel(pop);
    
    for i=1:nPop
        pop(i).IsDominated=false;
    end
    
    for i=1:nPop-1
        for j=i+1:nPop
            
            if Dominates_2(pop(i),pop(j))
               pop(j).IsDominated=true;
            end
            
            if Dominates_2(pop(j),pop(i))
               pop(i).IsDominated=true;
            end
            
        end
    end

end

