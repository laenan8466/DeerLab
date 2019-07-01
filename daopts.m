classdef daopts
    
    properties
        BackgroundModel = 'exponential'
        ModelParam = [];
        FitStartSearch = 'auto'
        FitStartPos = [];
        EndCutoffPos = [];
        PhaseCorrection = 'auto';
        Phase = [];
        ZeroTime = [];
    end
    
    properties (SetAccess = private)
        
    end
    
    properties (Hidden)
        ID
    end
    
    methods
        
        function obj = daopts(varargin)
            if nargin>0
                if mod(nargin,2)
                    error('Wrong number of arguments')
                end
                for i=1:2:length(varargin)
                    obj = setProperty(obj,varargin{i},varargin{i+1});
                end
            end
            JavaID =  java.util.UUID.randomUUID;
            obj.ID = JavaID.toString;
        end
        
        function obj = set.BackgroundModel(obj,string)
            allowedInput = {'exponential','polynomial','polyexp','fractal'};
            if any(strcmp(allowedInput,string)) && ~isa(string,'numerical')
                obj.BackgroundModel = string;
            else
                error('daopts:incorrectType','''%s'' is not a valid input of the BackgroundModel property.',string)
            end
        end
        
        function obj = set.FitStartSearch(obj,string)
            allowedInput = {'auto','manual'};
            if any(strcmp(allowedInput,string)) && ~isa(string,'numerical')
                obj.BackgroundModel = string;
                if strcmp(string,'auto')
                    obj.FitStartPos = [];
                else
                    obj.FitStartPos = 1;
                end
            else
                error('daopts:incorrectType','''%s'' is not a valid input of the FitStartSearch property.',string)
            end
        end
        
        function obj = set.ModelParam(obj,value)
            if ~isa(value,'numeric')
                error('daopts:incorrectType','Error \n ''%s'' is not a valid input of the ModelParam property.',value)
            end
            switch obj.BackgroundModel
                
                case {'exponential','polyexp','fractal'}
                    if ~isempty(value)
                        warning('ModelParam property is not required for the ''%s'' background model',obj.BackgroundModel)
                    end
                case 'polynomial'
                    if isempty(value)
                        error('ModelParam property is empty but required for the ''polynomial'' background model')
                    else
                        if value<0
                            error(' Negative values for the ModelParam property are not be adopted.')
                        end
                        if mod(value,1)~=0
                            error(' ModelParam property must be set to an integer number.')
                        else
                            obj.ModelParam = value;
                        end
                    end
            end
        end
        
        function obj = set.PhaseCorrection(obj,string)
            allowedInput = {'auto','manual'};
            if any(strcmp(allowedInput,string)) && ~isa(string,'numerical')
                obj.BackgroundModel = string;
                if strcmp(string,'auto')
                    obj.Phase = [];
                end
            else
                error('daopts:incorrectType','''%s'' is not a valid input of the PhaseCorrection property.',string)
            end
        end

        function obj = set.Phase(obj,value)
            if ~isa(value,'numeric')
                error('daopts:incorrectType','Error \n ''%s'' is not a valid input of the Phase property.',value)
            end
            if strcmp(obj.PhaseCorrection,'auto')
                warning('PhaseCorrection property is set to ''auto''. The Phase property is not required and will not be set.')
            else
                if value<0
                    error(' Negative values for the Phase property are not permited.')
                end
                obj.Phase = value;
            end
        end
        
    end
    
    methods(Access = private)
        
        function obj = setProperty(obj,Property,Value)
            if ~isa(Property,'char') && ~isa(Property,'string')
                error('daopts:incorrectType','Error \n Invalid first data argument')
            end
            eval(sprintf('obj.%s = Value;',Property));
        end
    end
    
end