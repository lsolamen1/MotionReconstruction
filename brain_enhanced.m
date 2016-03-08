 

Names=GetDicomFiles;
N=size(Names,1);
count = 0; %Robbie added

for kDir=1:N
        txt=dicominfo(deblank(Names(kDir,:)));
        IM=double(dicomread(deblank(Names(kDir,:))));
        [nx ny nl]=size(IM);
        Vel_dir=find(txt.VelocityEncodingDirection);

         % Robbie added starting here
        if Vel_dir == 1
            count = count + 1;
        elseif Vel_dir ==2
            count = count + 5;
        elseif Vel_dir ==3
            count = count + 10;
        end
        
        dst=nl/3;
        nPH=8;
        nSL=dst/nPH;
        
        % split up magnitude images, pca images, and velocity images
        Mag=IM(:,:,1,1:dst);
        PCA=IM(:,:,1,dst+1:2*dst);
        Vel=IM(:,:,1,2*dst+1:end);
        
        % split up slices
        for kSL=1:nSL
            MagIm(:,:,kSL,Vel_dir)=Mag(:,:,nPH*(kSL-1)+1);
            PCAIm(:,:,kSL)=PCA(:,:,nPH*(kSL-1)+1);
            Raw=Vel(:,:,nPH*(kSL-1)+1:nPH*kSL);
            bf=fft(Raw,[],3);
            Motion1(:,:,kSL,Vel_dir)=bf(:,:,2);%*txt.RescaleSlope + txt.RescaleIntercept;             
        end 
end

if count ==1        % Robbie added
    errordlg('The Y and Z directions are missing')
elseif count ==5
    errordlg('The X and Z directions are missing')
elseif count ==10
    errordlg('The X and Y directions are missing')
elseif count ==6
    errordlg('The Z direction is missing')
elseif count ==11
    errordlg('The Y direction is missing')
elseif count ==15
    errordlg('The X direction is missing')
end

A=abs(Motion1); P=angle(Motion1);
save MRE_3DMotionData.mat MagIm A P 
save PCA.mat PCAIm

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
