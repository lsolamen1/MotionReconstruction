clear all;

files=dir('*PAR');
nf=length(files);

for k=1:nf
    [a b c]=imgRecon_parrec_IABRAIN([files(k).name]);
    save b;
    %Saving b so that it can be read in for DirRead Ligin Solamen
    [nx ny nsl necho nph ntype]=size(a);
    if (nph==8)
        MagIm=zeros(nx,ny,nsl,3); Motion=zeros(nx,ny,nsl,3);
        break
    end
end
count = 0; %Robbie added
for k=1:nf
    [a b c]=imgRecon_parrec_IABRAIN([files(k).name]);
    [nx ny nsl necho nph ntype]=size(a);
	save b;
    if (nph==8)         % parrec is one of the directions
        dr=find(b.venc);
              % Robbie added starting here
        if dr == 1
            count = count + 1;
        elseif dr ==2
            count = count + 5;
        elseif dr ==3
            count = count + 10;
        end
        for ii=1:nsl           
            MagIm(:,:,ii,dr)=mean(a(:,:,ii,1,:,1),5);
            Raw(:,:,:,nsl)=squeeze(a(:,:,ii,1,:,3));
	    bf=fft(Raw(:,:,:,nsl),[],3);
	    Motion(:,:,ii,dr)=bf(:,:,2);
	    %Changed to 1 4.27.15 (2 is what it should be)
        end
        
    elseif (nph==1)     % parrec is one of the anatomical scans
        if strfind(b.protocol,'T2W_TSE_Clinical CLEAR')
            T2clin=a;
            save T2clin.mat T2clin
        elseif strfind(b.protocol,'T2W_TSE CLEAR')
            T2=a;
            save T2.mat T2          
        elseif strfind(b.protocol,'T1W_SE CLEAR')
            T1=a;
            save T1.mat T1
        elseif strfind(b.protocol,'VEN_BOLD_HR')
            VB=a;
            save VB.mat VB  
        elseif strfind(b.protocol,'BLACK_BLOOD')
            BB=a;
            save BB.mat BB
        elseif strfind(b.protocol,'T2W_FLAIR_MRE CLEAR')
            FLAIR=a;
            save FLAIR.mat FLAIR              
        else
            disp('don''t recognize this filetype')
        end
    else
        disp('not sure what kind of file this is...');
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
    
A=abs(Motion); P=angle(Motion);
MagIm=mean(MagIm,4);

save MRE_3DMotionData.mat A P MagIm

save RawData.mat Raw

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
