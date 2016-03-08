% Script to demonstrate the Blockunwrap works.
clear all;close all

parnme='testdata/pat3026_11_1.PAR'
load testdata/Mask.mat
UnwrapFlag=1;

[a,b,c]=imgRecon_parrec(parnme);
MagIm(:,:,:) = mean(a(:,:,:,1,1,1,:),7);
clear Gcim;
if c(6)==2
    Gcim(:,:,:,:) = a(:,:,:,1,1,2,:);
elseif c(6)==4
    Gcim(:,:,:,:) = angle(a(:,:,:,1,1,2,:) + 1i*a(:,:,:,1,1,3,:));
    %Gcim(:,:,:,:) = a(:,:,:,1,1,4,:);
end



Gcim = permute(Gcim,[1 2 4 3]);
UGcim = BlockUnwrapping(Gcim,mask,UnwrapFlag);

%% Reverse the effect of the permute to put UGcim in the same format as GCim
Gcim = permute(Gcim,[1 2 4 3]);
UGcim = permute(UGcim,[1 2 4 3]);


%% Slice and dynamic to plot
slice=9;
dyn=4;

figure(1)
imagesc(mask(:,:,slice).*Gcim(:,:,slice,dyn));
title(['Slice ' int2str(slice) ,', dynamic ' int2str(dyn) ' Before Unwrapping'])
xlabel('Notice the phase jumps (red-blue borders)')
C1=get(gca,'clim');colorbar

figure(2)
imagesc(UGcim(:,:,slice,dyn));
title(['Slice ' int2str(slice) ,', dynamic ' int2str(dyn) ' after Unwrapping'])
C2=get(gca,'clim');colorbar

% set to the same colormap
for ii=1:2
figure(ii);caxis([min(C1(1),C2(1)) min(C1(2),C2(2))])
end


figure;plot(reshape(UGcim(96,46,10,:),[1 8]),'bx-')
title('Sinusiodal motion measured at 8 phase points')

