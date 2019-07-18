function [err,data] = test(opt,olddata)

%=======================================
% Check Tikhonov regularization
%=======================================

Dimension = 200;
TimeStep = 0.008;
TimeAxis = linspace(0,TimeStep*Dimension,Dimension);
DistanceAxis = time2dist(TimeAxis);
Distribution = gaussian(DistanceAxis,3,0.5);
Distribution = Distribution/sum(Distribution);

Kernel = getKernel(TimeAxis,DistanceAxis);
DipEvoFcn = Kernel*Distribution;

%Set optimal regularization parameter (found numerically lambda=0.13)
RegParam = 0.13;
Result = regularize(DipEvoFcn,Kernel,'tikhonov',RegParam,'Solver','fmincon');
err(1) = any(abs(Result - Distribution)>1e-2);
err = any(err);
data = [];

if opt.Display
 	figure(8),clf
    hold on
    plot(DistanceAxis,Distribution,'k') 
    plot(DistanceAxis,Result,'r')
end

end