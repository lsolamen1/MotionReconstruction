% BuildAirMask.
% Automatically generate an 'air' mask (for calcualting noise), by finding the boundaries of the
% data inside the imaging volume. The actual imaged volume is expanded to a
% square, and all values outside of the volume are set to -308.6 in the
% real and imag parts for some reason. So the air mask needs to avoid these
% regions, and also have some reliable threshold which avoids data which is
% not measured in air.
% Saves output in Mask_Air.mat, variable named mask_air
% inputs: a = first output of imgRecon_parrec

function [mask_air]=AirMask(a)


%pfile=getfilename('PAR File ','*.PAR');
%[a b c]=imgRecon_parrec(pfile);



sz=size(a);
% Create an estimated magnitude image from the real and imag parts (MR mag
% (index 6 =1) is processed in some sort of strange way.
Mag=zeros(sz(1:3));
for ii=1:sz(7)
    if(size(a,6)==2)
        Mag=Mag+a(:,:,:,1,1,1,ii);
    else
        Mag=Mag+abs( a(:,:,:,1,1,2,ii)+1i.*a(:,:,:,1,1,3,ii) );
    end
end

[mde,f]=mode(Mag(:)); % Most frequently occuring value is the default value for voxels outside the imaging volume.

if(f<200);
    warning('Cannot determine default value for pixels outside of imaging volume')
end

montagestack(Mag)
title('Magnitude (from real and imag part)')

% Create Mask of the high signal MRE data
thr = graythresh(Mag./max(Mag(:)));  % Use otsu's method 
mask1=(Mag > thr.*max(Mag(:)));

% Fill in any holes
%mask2 = imfill(mask1,'holes');  % Causing matlab to crash for some reason....
mask2=mask1;


% Dilate
dilsiz=2;
se=strel(ones(1+2*dilsiz,1+2*dilsiz,1+2*dilsiz));
mask3=imdilate(mask2,se);
montagestack(mask3)
title('High signal Mask')

mask4=Mag==mde;
montagestack(mask4);
title('Default value Mask')


mask_air=~mask4&~mask3;
montagestack(mask_air)
title('Final Air Mask')


junk=Mag;
junk(mask_air)=max(Mag(:));
montagestack(junk)
title('overlaid on Magnitude image')

save Mask_Air mask_air

end
