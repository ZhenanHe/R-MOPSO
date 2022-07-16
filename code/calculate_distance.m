function [ Dis ] = calculate_distance( customerloc,depotloc )
[customernumber,~]=size(customerloc);
Dis=zeros(customernumber+1,customernumber+1);
loc=[depotloc;customerloc];
for i=1:customernumber+1
    for j=1:customernumber+1
        Dis(i,j)=sqrt((loc(i,1)-loc(j,1))^2+(loc(i,2)-loc(j,2))^2);
        if Dis(i,j)==0
            Dis(i,j)=10^-6;
        end
    end

end

