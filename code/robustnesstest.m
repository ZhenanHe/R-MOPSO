function [robust,extreme]=robustnesstest(PF,ser,timewindow,dis,phi)

robust=0;
for j=1:50
    robust=robust+robustnesssample(PF.route,dis,timewindow,phi,ser);
end
robust=robust/50;
extreme=extremesample(PF.route,dis,timewindow,phi,ser);


    

end

