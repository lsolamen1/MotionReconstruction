

%% INITIALIZE FIELDS
tic
Names=GetFileNames;  
N=size(Names,1); SLoc=zeros(1,N); TrigTime=zeros(1,N); Ser=zeros(1,N);
Vel=zeros(1,N); Mag=zeros(1,N); PCA=zeros(1,N); VelDir=zeros(1,N);
aT1=zeros(1,N); aT2=zeros(1,N); aBB=zeros(1,N); aVB=zeros(1,N); aT2clin=zeros(1,N);

%% READ ALL IMAGES AND SORT MAGNITUDE, PCA AND VELOCITY TAGS
for k=1:N
  try
    txt=dicominfo(deblank(Names(k,:)));
    Ser(k)=txt.SeriesNumber;
    
    if (strfind(txt.ImageType,'PRIMARY\M_FFE') & strfind(txt.SeriesDescription,'QFLOW'))
        Mag(k)=1;
        SLoc(k)=txt.SliceLocation; 
        TrigTime(k)=txt.TriggerTime;
    end
    
    if (strfind(txt.ImageType,'PRIMARY\M_PCA') & strfind(txt.SeriesDescription,'QFLOW'))
        PCA(k)=1;
        SLoc(k)=txt.SliceLocation; 
        TrigTime(k)=txt.TriggerTime;        
    end
    
    if strfind(txt.ImageType,'VELOCITY')
        Vel(k)=1;
        SLoc(k)=txt.SliceLocation; 
        TrigTime(k)=txt.TriggerTime;        
    end
    
    if Vel(k)>0
        VelDir(k)=find(txt.Private_2005_140f.Item_1.VelocityEncodingDirection);
    end
    
    if strcmp(txt.SeriesDescription,'T1W_SE') 
        aT1(k)=1;
    end

    if strcmp(txt.SeriesDescription,'T2W_TSE')
        aT2(k)=1;
    end
    
    if strcmp(txt.SeriesDescription,'T2W_TSE_Clinical')
        aT2clin(k)=1;
    end

    if strcmp(txt.SeriesDescription,'BLACK_BLOOD') 
        aBB(k)=1;
    end

    if strcmp(txt.SeriesDescription,'VEN_BOLD_HR') 
        aVB(k)=1;
    end    
  catch
  end
end

%% ANATOMICALS
inT1=find(aT1); 
inT2=find(aT2); 
inBB=find(aBB); 
inVB=find(aVB);
inT2clin=find(aT2clin);

if ~isempty(inT1)
    bf=double(dicomread(deblank(Names(inT1(1),:)))); 
    T1=zeros(size(bf,1),size(bf,2),length(inT1));
    for k=1:length(inT1)
        T1(:,:,k)=double(dicomread(deblank(Names(inT1(k),:))));    
    end
    save T1.mat T1
end

if ~isempty(inT2)
    bf=double(dicomread(deblank(Names(inT2(1),:)))); 
    T2=zeros(size(bf,1),size(bf,2),length(inT2));
    for k=1:length(inT2)
        T2(:,:,k)=double(dicomread(deblank(Names(inT2(k),:))));    
    end
    save T2.mat T2
end

if ~isempty(inT2clin)
    bf=double(dicomread(deblank(Names(inT2clin(1),:)))); 
    T2clin=zeros(size(bf,1),size(bf,2),length(inT2clin));
    for k=1:length(inT2clin)
        T2clin(:,:,k)=double(dicomread(deblank(Names(inT2clin(k),:))));    
    end
    save T2clin.mat T2clin
end

if ~isempty(inBB)
    bf=double(dicomread(deblank(Names(inBB(1),:)))); 
    BB=zeros(size(bf,1),size(bf,2),length(inBB));
    for k=1:length(inBB)
        BB(:,:,k)=double(dicomread(deblank(Names(inBB(k),:))));    
    end
    save BB.mat BB
end

if ~isempty(inVB)
    bf=double(dicomread(deblank(Names(inVB(1),:)))); 
    VB=zeros(size(bf,1),size(bf,2),length(inVB));
    for k=1:length(inVB)
        VB(:,:,k)=double(dicomread(deblank(Names(inVB(k),:))));    
    end
    save VB.mat VB
end

%% READ AND WRITE TO FILE MAGNITUDE, VELOCITY, PCA 
nPh=8;
in=find(Vel==1);
in1=find(Mag==1);
in2=find(PCA==1);
SL=unique(SLoc(in));                                % unique location of slices
nSl=length(SL);                                     % number of slices
SS=unique(VelDir(in));                              % unique velocity direction
im=double(dicomread(deblank(Names(in(1),:))));      % image values
n=size(im);                                         % size of images
Motion1=zeros(n(1),n(2),nSl,length(SS));            % size of motion
MagIm_8PH=zeros(n(1),n(2),nSl,nPh,3);               % size of MagIm with 8 phases
MagIm=zeros(n(1),n(2),nSl,3);                       % size of MagIm
PCAIm=zeros(n(1),n(2),nSl);                         % size of PCAIm

%% MAGNITUDE IMAGE
for k=1:nSl
  id=find(SLoc(in1)==SL(k));
  for jj=1:nPh
    MagIm_8PH(:,:,k,jj,1)=double(dicomread(deblank(Names(in1(id(jj)),:)))); 
  end
  MagIm(:,:,k,:)=mean(MagIm_8PH(:,:,k,:,:),4);
end

%% PCA
for k=1:nSl
  id=find(SLoc(in2)==SL(k));
  PCAIm(:,:,k)=double(dicomread(deblank(Names(in2(id(1)),:))));  
end
save PCA.mat PCAIm

%Robbie added:
if SS ~= 3
    errordlg('There is a missing direction')
end

%% VELOCITY DATA
for kSS=1:length(SS) % direction loop
  for kSlice=1:nSl % slice loop
      in=find(VelDir==SS(kSS) & SLoc==SL(kSlice));
      TT=unique(TrigTime(in));
      nTT=length(TT);
      Raw=zeros(n(1),n(2),nTT);
      for kTrig=1:nTT % trigger loop
          in=find(VelDir==SS(kSS) & SLoc==SL(kSlice) & TrigTime==TT(kTrig));
          if length(in)<1
              disp(['No Image File Found for: VelDir= ',num2str(SS(kSS)),...
                  'Sloc= ',num2str(SL(kSlice)),'  TrigTime= ',num2str(TT(kTrig))]);
              break
          end
          if length(in)>1
              disp(['More Than One Image File Found for: VelDir= ',num2str(SS(kSS)),...
                  'Sloc= ',num2str(SL(kSlice)),'  TrigTime= ',num2str(TT(kTrig))]);
              in=in(1);
          end
          Raw(:,:,kTrig)=double(dicomread(deblank(Names(in(1),:))));
      end
      txt=dicominfo(deblank(Names(in(1),:)));
      Raw=Raw*txt.RescaleSlope + txt.RescaleIntercept;
      bf=fft(Raw,[],3);
      Motion1(:,:,kSlice,kSS)=bf(:,:,2);
    
  end
end

A=abs(Motion1); P=angle(Motion1);
save MRE_3DMotionData.mat MagIm A P

%Robbie added:         
Ur = A.*cos(P);
montagestack(Ur(:,:,:,1))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ur-X')
Ui = A.*sin(P);
montagestack(Ui(:,:,:,1))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ui-X')

Ur = A.*cos(P);
montagestack(Ur(:,:,:,2))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ur-Y')
Ui = A.*sin(P);
montagestack(Ui(:,:,:,2))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ui-Y')
 
Ur = A.*cos(P);
montagestack(Ur(:,:,:,3))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ur-Z')
Ui = A.*sin(P);
montagestack(Ui(:,:,:,3))
Mayo_Awave_colormap
colorbar
caxis([-.2 .2])
title('Ui-Z')

toc