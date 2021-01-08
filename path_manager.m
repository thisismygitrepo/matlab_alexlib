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
        
        function posix = makeUnix(path)
           posix = strrep(path, "\", "/"); 
        end
        
        function result = join(varargin)
            result = "";
           for i=1:size(varargin, 1)
              tmp = makeUnix(varargin(i));
              if tmp(1) == "/"
                 result = result + tmp; 
              else
                  result = result + "/" + tmp;
              end
           end
           
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

        function outputArg = gettb(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = py.alexlib.toolbox;
        end
    end
    
   methods(Static)
       function p = path()
           p = py.alexlib.toolbox.P;
       end
   end
end


