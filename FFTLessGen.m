function [A, P, ErrorMap, Ptemp] = FFTLessGen(FileMtr, WinVector);
% function [A, P] = FFTLessGen(RawDataFile, WinVector, OutFile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function is based on FFT method using fewer points to reconstruct 
%% motion. WinVector includes the info that which points we will choose 
%% for reconstruction. 
%% For example, if the first and third points will be chosen, the function
%% can be written as: FFTLessGen('100HzRawdataD1.mat', [1 3]);
%% By Huifang Wang, May 21th, 2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load([RawDataFile]);
Gcim = FileMtr;

nX=size(Gcim,1);
nY=size(Gcim,2);
nPh=size(Gcim,3);
nS=size(Gcim,4);

MWindow = zeros(1,nPh);
MWindow(WinVector) = 1;
VWindow = 0:nPh-1;
VWindow = VWindow .* MWindow;

c1 = MWindow .* sin(4*VWindow.*pi/nPh);
c2 = MWindow .* cos(4*VWindow.*pi/nPh);
c1 = sum(c1);
c2 = sum(c2);
c3 = sum(MWindow);
C=[c3+c2 -c1; -c1 c3-c2];
Cinv=inv(C);

% Note that C = [8 0;0 8] and cinv = [1/8 0; 0 1/8] when using all 8 phase
% offsets.

t=[0:nPh-1];

for k=1:nS
    for ii=1:nX
        for j=1:nY            
            t0 = reshape(Gcim(ii,j,:,k),1,nPh);
            t0 = t0-mean(t0);
            t0 = t0.*MWindow;
            
            F0=fft(t0);
            Ptemp(ii,j,k,:)=abs(F0);
            Expr=[real(F0(2)); imag(F0(2))];
            % The amplitude should be 2/nph*F(2) to make real(A*exp(iwt)) consistent with the data in GCIM. The
            Truth=Cinv*Expr; % This will divide by 8 when all 8 phase offsets are used.                
            A(ii,j,k)=2*sqrt(Truth(1)^2+Truth(2)^2); % This gets the 2.
            if (Truth(1)==0)
                if (Truth(2)>0)
                    P(ii,j,k)= pi/2;  
                else
                    P(ii,j,k)= 3*pi/2;   
                end
            else
                P(ii,j,k)=atan(Truth(2)/Truth(1));               
            end
            if (Truth(1)<0)
                P(ii,j,k) = P(ii,j,k)+pi;
            end
            
			tD = A(ii,j,k).*cos(P(ii,j,k)+t.*2*pi/nPh);
			tD = tD.*MWindow;
			
            % Huifangs Initial ErrorMap
            % ErrorMap(ii,j,k) = sqrt(sum((tD-t0).^2)./nPh); old form
            
            % Alternative as the standard devaition of the misfit. 
            ErrorMap(ii,j,k)=std(tD-t0);
            % NOTE: Identify this new form by saving another variable
            % stdform = true in ErrorMap.mat
           
        end
    end
end
