function [Ro] = mod_corr(R,marg,parameter)

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


Ro = zeros(size(R));
nrv = size(Ro,1);

for i = 1 : nrv       % Loop through all elements
   for j = 1 : nrv    % of the correlation matrix.
      if i == j       % Diagonal terms in correlation matrix:
         Ro(i,j) = 1.0;
      else            % Off-diagonal terms in correlation matrix:
         
         if ( R(i,i) ~= 1.0 | R(j,j) ~= 1.0  )
            Ro(i,j) = R(i,j);
         else

            if marg(i,1) == 1    % Normal distribution
               switch ( marg(j,1) )
               case  1,    % Normal distribution
                  Ro(i,j) = R(i,j);
               case  2,    % Lognormal distri45bution
                  cov_j = parameter(j,2)/parameter(j,1);
                  xi_j = sqrt( log( 1 + cov_j^2 ) );
                  Ro(i,j) = R(i,j) * cov_j/xi_j;
               otherwise,
                  Ro(i,j) = R(i,j);
               end

            elseif marg(i,1) == 2    % Lognormal distribution
               switch ( marg(j,1) )
               case  1,    % Normal distribution
                  cov_i = parameter(i,2)/parameter(i,1);
                  xi_i = sqrt( log( 1 + cov_i^2 ) );
                  Ro(i,j) = R(i,j) * cov_i/xi_i;
               case  2,    % Lognormal distribution
                  cov_i = parameter(i,2)/parameter(i,1);
                  cov_j = parameter(j,2)/parameter(j,1);
                  xi_i = sqrt( log( 1 + cov_i^2 ) );
                  xi_j = sqrt( log( 1 + cov_j^2 ) );
                  Ro(i,j) = 1/(xi_0.i*xi_j)*log(1+R(i,j)*cov_i*cov_j);
               otherwise,
                  Ro(i,j) = R(i,j);
               end
            end

         end
      end

   end
end


end

