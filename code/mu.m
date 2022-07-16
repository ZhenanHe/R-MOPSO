function [ position ] = mu(position,varsize,ubmax,ubmin,timewindow)

delta=0.6*rand();
selectvar=randperm(varsize,round(varsize/2));
changevector=zeros(1,varsize);
for i=1:length(selectvar)
    changevector(selectvar(i))=(((timewindow(selectvar(i),2)-ubmin)/(ubmax-ubmin))-0.6)*delta;
end
position=position+changevector;
position=max(position,0);
position=min(position,1);
    


end

