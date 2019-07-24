function runValidation(ExpSignal,Parameters)

varparam = prepareValidation(Parameters);
varnames = {Parameters.name};
options = daoptions();
for i=1:size(varparam,1)
   
    %Set the current settings
    for j = 1:length(varnames) 
    options = setoptions(options,varnames{j},varparam{i,j});
    end
    %Run signal preparation
    ProcessedSignal = prepareSignal(ExpSignal,options);
    %Get the distribution
    Distribution(i) = getDistribution(ProcessedSignal,options);
end




end
