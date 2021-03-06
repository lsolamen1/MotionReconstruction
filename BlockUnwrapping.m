%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unwrap the raw data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag,TwoDFlag,OneDFlag);
function  UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag)
% The function unwraps 4D block of raw data for one direction.

nPh = size(Gcim,3);
nS = size(Gcim,4);

maskall = repmat(mask,[1 1 1 nPh]);
maskall = permute(maskall,[1 2 4 3]);
if UnwrapFlag == 0
    UGcim = Gcim;     return;
end

disp([int2str(nS) ' slices total'])
parfor j=1:nS
    UGcim(:,:,:,j) = Qual3DUnwrap(Gcim(:,:,:,j),maskall(:,:,:,j));
    disp(['slice ' int2str(j),' has been processed']);
end
