clear all; close all;

files=dir('*PAR');
nf=length(files);

for k=1:nf
    [a b c]=imgRecon_parrec_IABRAIN([files(k).name]);
    [nx ny nsl necho nph ntype]=size(a);
    if (nph==8)
        MagIm=zeros(nx,ny,nsl,3); Motion1=zeros(nx,ny,nsl,3);
        Motion2=zeros(nx,ny,nsl,3);
        Motion3=zeros(nx,ny,nsl,3);
        Motion4=zeros(nx,ny,nsl,3);
        break
    end
end

for k=1:nf
    [a b c]=imgRecon_parrec_IABRAIN([files(k).name]);
    [nx ny nsl necho nph ntype]=size(a);

    if (nph==8)         % parrec is one of the directions
        dr=find(b.venc);        
        for ii=1:nsl
            MagIm(:,:,ii,dr)=mean(a(:,:,ii,1,:,1),5);
            Raw=squeeze(a(:,:,ii,1,:,3));
            bf=fft(Raw,[],3);
            Motion1(:,:,ii,dr)=bf(:,:,2);
            Motion2(:,:,ii,dr)=bf(:,:,3);
            Motion3(:,:,ii,dr)=bf(:,:,4);
            Motion4(:,:,ii,dr)=bf(:,:,5);
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
        else
            disp('don''t recognize this filetype')
        end
    else
        disp('not sure what kind of file this is...');
    end
end

A1=abs(Motion1); P1=angle(Motion1);
A2=abs(Motion2); P2=angle(Motion2);
A3=abs(Motion3); P3=angle(Motion3);
A4=abs(Motion4); P4=angle(Motion4);
save MRE_3DMotionData.mat A1 A2 A3 A4 P1 P2 P3 P4 MagIm
        