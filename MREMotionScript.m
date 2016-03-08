% function MREMotionScript(ParFileM,ParFileP,ParFileS,Flag,MaskFile,TwoDFlag,OneDFlag)
function MREMotionScript(ParFileM,ParFileP,ParFileS,Flag,MaskFile,TwoDFlag)
%% The MREMotionScript reads raw par/rec file and reconstruct motion for MRE. 
%% ParFileM, ParFileP and ParFileS: The name of .PAR file for each direction. 
%% Flag: 0--No unwrapping; 1--Creat magnitude file only; 2--With Unwrapping. 
%% MaskFile: .MAT file that contains variable 'mask'. 
%%           It specify a 2D or 3D mask.
%% TwoDFlag: 0--Quality-guided unwrapping, default; 1--Goldstein's unwrapping.
%% OneDFlag: 0--Normal range motion, default; 1--Large range motion.
%% Examples:
%%      No unwrapping: MREMotionScript('M.PAR','P.PAR','S.PAR')
%%      Retrieve Magn only: MREMotionScript('M.PAR','P.PAR','S.PAR',1)
%%      Unwrapping without a mask: MREMotionScript('M.PAR','P.PAR','S.PAR',2)
%%      Unwrapping with a mask: MREMotionScript('M.PAR','P.PAR','S.PAR',2,'mask.mat')
%%
%% Created by Huifang Wang, 11/20/2006
%% Modified by Huifang Wang, 01/24/2008
%% Changed the unwrapping method to three-dimensional quality-guided method. 

fname(1,:) = ParFileM;
[pathname, name] = FindName(fname(1,:));
[a,b,c] = imgRecon_parrec(fname(1,:));
nX = c(1);
nY = c(2);
nS = c(3);
nPh = c(7);
DirIndex = DirRead(b);
mask = ones(nX,nY,nS);

if nargin>1    fname(2,:) = ParFileP;   end
if nargin>2    
    fname(3,:) = ParFileS;   
    if nargin==3
        Flag = 0;
    end
end
if nargin>3
    if Flag == 1
        display('Creating magnitude file only!');
        CreatMagIm(fname,pathname);
        return;
%     elseif nargin==4 & Flag == 2  %% Unwrapping without mask
%         TwoDFlag = 0;
%         OneDFlag = 0;
    end
end
if nargin>4
    if Flag == 2    %% Unwrapping with mask
        load(MaskFile);
    end
%     if nargin == 5
%         TwoDFlag = 0;
%         OneDFlag = 0;
%     end
%     if nargin == 6
%         OneDFlag = 0;
%     end    
end

NDir = size(fname,1);
fletter = 'MPS';
WinVector = 1:nPh;  %% Using full data reconstruction


% Start reconstruction

for i=1:NDir
    if isempty(fname(i,:)) == 1
        errordlg(['Please specify the par/rec file in ', fletter(i),' direction.']);
        return;
    else
        disp(['Reconstruct direction ',num2str(i),':']);
        [a,b,c]=imgRecon_parrec(fname(i,:));
        MagIm(:,:,:,i) = mean(a(:,:,:,1,1,1,:),7);
        clear Gcim;
        if c(6)==2
            Gcim(:,:,:,:) = a(:,:,:,1,1,2,:);
        elseif c(6)==4
            Gcim(:,:,:,:) = a(:,:,:,1,1,4,:);
        end
		Gcim = permute(Gcim,[1 2 4 3]);
        if Flag == 2
            mlen = size(mask);
            if length(mlen)==2
                mask = repmat(mask,[1 1 nS]);
            end
%             Gcim = BlockUnwrapping(Gcim,mask,Flag,TwoDFlag,OneDFlag);
            Gcim = BlockUnwrapping(Gcim,mask,Flag);
        end
		[A(:,:,:,i), P(:,:,:,i), ErrorMap(:,:,:,i), FPower(:,:,:,:,i)] = FFTLessGen(Gcim, WinVector);
%         if SaveRaw==1
%         save([pathname,'Raw',fletter(i),'.mat'], 'Gcim');
%         end
    end
end
MagIm = mean(MagIm,4);
maskall = repmat(mask,[1 1 1 3]);
MagIm = mask.*MagIm;


name1 = 'MRE_3DMotionData.mat';
A = A.*maskall;
P = P.*maskall;
save([pathname,name1],'MagIm','A','P','-v6');
name2 = 'HeaderData.mat';
% freqHz = 85.01588;
freqHz = 100.037;
save([pathname,name2],'DirIndex','freqHz','-v6');
name1 = 'MagIm.mat';
save([pathname,name1],'MagIm','-v6');
ErrorMap = ErrorMap.*maskall;
save([pathname,'ErrorMap.mat'], 'ErrorMap','FPower','-v6');

disp('The motion reconstruction is done!');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CreatMagIm(fname,pathname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NDir = size(fname,1);

for i=1:NDir
    if isempty(fname(i,:)) == 1
        errordlg(['Please specify the par/rec file in ', fletter(i),' direction.']);
        return;
    else
        [a,b,c]=imgRecon_parrec(fname(i,:));
        MagIm(:,:,:,i) = mean(a(:,:,:,1,1,1,:),7);
    end
end
MagIm = mean(MagIm,4);

name1 = 'MagIm.mat';
save([pathname,name1],'MagIm','-v6');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Save data to the rawdata directory
% function [pathname, name] = FindName(filename)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % function [pathname, name] = FindName(filename,filesuffix);
% % filename   starting file name from a list of files that need to be read
% % filesuffix the filefuffix to be saved
% % DataMtr    data matrix to be saved
% % handles    structure with handles and user data (see GUIDATA)
% 
% a = find(filename=='\');
% if isempty(a)
%     a = find(filename=='/');
% end
% name = filename(max(a)+1:length(filename));
% pathname = filename(1:max(a));


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Unwrap the raw data
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % function  UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag,TwoDFlag,OneDFlag);
% function  UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag)
% % The function unwraps 4D block of raw data for one direction.
% 
% if UnwrapFlag == 0
%     UGcim = Gcim;     return;
% end
% 
% nS = size(Gcim,4);
% for j=1:nS
%     UGcim(:,:,:,j) = Qual3DUnwrap(Gcim(:,:,:,j),mask);
%     disp([num2str(j*100/nS),'% has been finished!']);
% end
