% Code to evaluate the noise in a Par Rec file using the standard
% deviation of Air regions. Generate Mask_Air.mat using /code/misc/AirMask.m
% Outputs: stdr_m = standard devation of real part of MR image
%          stdi_m = standard devation of imag part of MR image
% inputs: a = first output of imgRecon_parrec
% These are usually about equal for most of the data I have tried.
% Can use these to find std_phase (1/abs(MR)), then std_motion (sqrt(2/N))

function [stdr_m,stdi_m]=Noise_ParRec(a,mask_air)

%pfile=getfilename('PAR File ','*.PAR');
% [a b c]=imgRecon_parrec(pfile);

% a(:,:,:,1,1,1,i) = magnitude of timepoint i.
% a(:,:,:,1,1,2,i) = real of timepoint i.
% a(:,:,:,1,1,3,i) = imag of timepoint i.
% a(:,:,:,1,1,4,i) = calculated phase of timepoint i.

% Air data from supplied mask
% load Mask_Air.mat
% msk_air=mask;
I=find(mask_air==1);

% Actual mask used for image
load Mask
I2=find(mask==1);

stdr=zeros(1,8);
stdi=zeros(1,8);
stdm=zeros(1,8);
meanr=zeros(1,8);
meani=zeros(1,8);
meanm=zeros(1,8);

for ii=1:8
    % Real Part
    if(size(a,6)==2)
        junk=a(:,:,:,1,1,1,ii).*cos(a(:,:,:,1,1,2,ii));
    else
        size(a)
        ii
        junk=a(:,:,:,1,1,2,ii);
    end
    stdr(ii)=std(junk(I));
    meani(ii)=mean(abs(junk(I2)));
    % Imag Part
    if(size(a,6)==2)
        junk=a(:,:,:,1,1,1,ii).*sin(a(:,:,:,1,1,2,ii));
    else
        junk=a(:,:,:,1,1,3,ii);
    end
    stdi(ii)=std(junk(I));
    meanr(ii)=mean(abs(junk(I2)));
    % Magnitude
    junk=a(:,:,:,1,1,1,ii);
    stdm(ii)=std(junk(I));    
    meanm(ii)=mean(junk(I2));
end

stdr_m=mean(stdr);
stdi_m=mean(stdi);

%disp(['PAR-file: ' pfile ' MR Image Noise Estimate [ Real Imag ], std(air pixels) = '])
disp('Noise in real and imag parts of MR image')
disp([stdr_m stdi_m]) 

if(0==1) % Output more info
    disp('[stdreal stdimag stdmag]')
    disp([stdr' stdi' stdm'])
    disp('means')
    disp(mean([stdr' stdi' stdm']))

    disp('[meanreal meanimag meanmag]')
    disp([meanr' meani' meanm'])

    disp('Noise Percent Real Imag Mag:')
    disp([mean(stdr)/mean(meanr)*100 mean(stdi)/mean(meani)*100 mean(stdm)/mean(meanm)*100])
end




end

