function  [ x ] = u_to_x(u,marg,parameter,Lo)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finite Element Reliability using Matlab, FERUM, Version 3.0       %
%                                                                   %
% This program is free software; you can redistribute it and/or     %
% modify it under the terms of the GNU General Public License       %
% as published by the Free Software Foundation; either version 2    %
% of the License, or (at your option) any later version.            %
%                                                                   %
% This program is distributed in the hope that it will be useful,   %
% but WITHOUT ANY WARRANTY; without even the implied warranty of    %
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     %
% GNU General Public License for more details.                      %
%                                                                   %
% A copy of the GNU General Public License is found in the file     %
% <gpl.txt> following this collection of program files.             %
%                                                                   %
% Developed under the sponsorship of the Pacific                    %
% Earthquake Engineering (PEER) Center.                             %
%                                                                   %
% For more information, visit: http://www.ce.berkeley.edu/~haukaas  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


marg_dim = size(marg);     nrv = marg_dim(1);

z = Lo * u;
for i = 1 : nrv
   switch marg(i,1)
      case 1        % Normal distribution
         x(i) = z(i) * parameter(i,2) + parameter(i,1);
      case 2        % Lognormal distribution
         xi = parameter(i,4);
         lambda = parameter(i,3);
         x(i) = exp(  z(i) * xi + lambda  );
      otherwise
   end
end

x = x';