%
%   ISNANOMETER
%
%   logical = ISNANOMETER(r)
%   If the distance axis is in nanometers, the function returns (true), if
%   it is in angstrom it returns (false).
%

% This file is a part of DeerAnalysis. License is MIT (see LICENSE.md). 
% Copyright(c) 2019: Luis Fabregas, Stefan Stoll, Gunnar Jeschke and other contributors.

function logical = isnanometer(r)

if iscolumn(r)
    r = r.';
end

if max(r)<20
    logical = true;
else
    logical = false;
end

end