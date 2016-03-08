function IAbrainMotionRecon2
%% reads the input raw data files acquired with intrinsic activation
clear all; close all
ndcm=dir('IM_*');
npr=dir('*.PAR');
nenh=dir('*.dcm');

if(size(ndcm,1)~=0)
    brain_DICOM
elseif(size(npr,1)~=0)
    brain_PARREC2
elseif(size(nenh,1)~=0)
    brain_enhanced
else
    disp('none of the correct file types are listed')
end


%% generate header data file
freqHz=1;
fat_shift=input(['What is the fat shift? (Ex:F):>>'],'s');

%parfiles=dir('*PAR');
%nf=length(parfiles);
%if size(nf)~=3
%    disp('You do not have the appropriate number of Par Rec files')
%end
%filename=parfiles(2,1).name;
%[A B C]=imgRecon_parrec(filename);
load parms.mat
DirIndex = DirRead(parms,fat_shift);
%DirIndex=zeros(4,6);
%DirIndex(1,1)=1; DirIndex(2,2)=1; DirIndex(3,3)=1;
%DirIndex(1,4)=-1; DirIndex(2,5)=-1; DirIndex(3,6)=1;
%DirIndex(4,1)=0.893; DirIndex(4,2)=0.893; DirIndex(4,3)=3;
save HeaderData.mat freqHz DirIndex

%% generate meshing input file
 fls=dir('*PAR');
 fn=fls(1).name;
 fname=fn(1:5);
 
 inputfile='input';
 fid=fopen(inputfile,'w');
 fprintf(fid,'3\n');
 fprintf(fid,[fname '\n']);
 fprintf(fid,'0.003\n');
 fprintf(fid,'ligin.m.solamen.th@dartmouth.edu\n');
 fprintf(fid,'0.85d0\n');
 fprintf(fid,'200\n');
 fprintf(fid,'1d-4\n');
 fprintf(fid,'16\n');
 fclose(fid);
delete('b.mat')
clear all;
end