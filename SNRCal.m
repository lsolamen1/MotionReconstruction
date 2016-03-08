
% % SNR in motion
% clear;
% load ErrorMap
% load MRE_3DMotionData
% load Mask
% 
% SR = A./ErrorMap;
% a = find(isinf(SR)==1);
% SR(a) = 100;
% b = find(isnan(SR)==1);
% SR(b) = 0;
% for i=1:3
%     St = SR(:,:,:,i).*mask;
%     SAvg(i) = sum(abs(St(:)))./sum(mask(:));    
% end
% 
% SAvg
% mean(SAvg)

% %% SNR in MagIm images
% c = MagIm(9:74,66:77,:);
% Mt = MagIm.*mask;
% MAvg = sum(Mt(:))./sum(mask(:));
% MAvg./std(c(:))

% Mt = MagIm.*mask;
% c = find(Mt>0);
% Ct = Mt(c);
% MAvg = sum(Ct(:))./sum(mask(:));
% MAvg./std(Ct(:))

%% Amp. 
maskall = repmat(mask,[1 1 1 3]);
A = A.*maskall;
AAvg = sum(A(:))./sum(maskall(:))

%% Error.
maskall = repmat(mask,[1 1 1 3]);
ErrorMap = ErrorMap.*maskall;
EAvg = sum(ErrorMap(:))./sum(maskall(:))

