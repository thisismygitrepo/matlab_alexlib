classdef path_manager
    %PATH_MANAGER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        onedrive;
        gdrive;
        rdrive;
        data;
        home;
    end
    
    methods(Static)
        
        function result = fix(path)
           tmp = string(path);  % assert that it is a string not a char           
           result = strrep(tmp, "\", string(filesep)); % only works on strings.
           result = strrep(result, "/", string(filesep)); % only works on strings.
           result = char(result);
           if result(end) == filesep  % remove filesep from the end of the path if it exists.
               result = result(1:end - 1);
           end
           result = string(result);
        end
        
        function result = join(varargin)
           result = "";  % result is a string
           
           for i=1:length(varargin)  
              tmp = char(path_manager.fix(varargin{i}));
              % convert it to char so that we can access the first elem.
              if (tmp(1) == filesep) || i == 1  % do not add "/\" to first item, nor an item that has filesep at its start already.
                 result = result + tmp; % char is coerced into string.
              else
                  result = result + filesep + tmp;
              end
           end
           
        end
        
        function add_tomlib(path)
           if nargin == 1
               addpath(path)
           else
               % try to do it automatically, but error here should never
               % pass silently.
               path = path_manager.join(path_manager.absfrom('toml'), 'tomlib');
               if exist(path, 'dir') == 0
                  error("Could not add tomlib automatically. Pass it manually instead"); 
               end
               addpath(path)
           end
        end
        
        function abspath = absfrom(name)
            parts = split(pwd, name);
            abspath = path_manager.join(parts{1}, name);
        end
    end
    
    methods
        function obj = path_manager()
%             machine = computer;
%             if machine == "GLNXA64"
%                 obj.machine = "linux";
%             elseif machine == "MACI64"
%                 obj.machine = "mac";
%             else
%                 obj.machine = "windows";
%                 obj.gdrive = "G:\";
%             end
            obj.home = string(java.lang.System.getProperty('user.home'));
            obj.gdrive = fullfile(obj.home, "my_g_drive");
            obj.onedrive = fullfile(obj.home, "my_one_drive");
            obj.data = fullfile(obj.home, "my_data");
            obj.rdrive = fullfile(obj.home, "my_r_drive");
        end

%         function outputArg = gettb(obj)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = py.alexlib.toolbox;
%         end
    end

%    methods(Static)
%        function p = path()
%            p = py.alexlib.toolbox.P;
%        end
%    end

end


