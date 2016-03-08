 function [A,P,tD,tRm] = FFTReconSingle(p,nPh)
 % tRm is the RMS of the recon.

p = p-mean(p);

t=[0:nPh-1];
temp = fft(p);
A = abs(temp(2))/(nPh/2);
P = angle(temp(2));
tD = A.*cos(P+t.*2*pi/nPh);
% tRm = sqrt(sum((tD-p).^2)./nPh)/A;
tRm = sqrt(sum((tD-p).^2)./nPh);

%%% Same as angle function
% Truth(1) = real(temp(2));
% Truth(2) = imag(temp(2));
% if (Truth(1)==0)
%     if (Truth(2)>0)
%         P = pi/2;  
%     else
%         P = 3*pi/2;   
%     end
% else
%     P = atan(Truth(2)/Truth(1));               
% end
% if (Truth(1)<0)
%     P = P+pi;
% end

