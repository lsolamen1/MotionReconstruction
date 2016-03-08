%Create MagIm from ParRec Files to use with Stack_Segment to create masks
%and segmentations

parf=dir('*.PAR');

if(length(parf)>3)
    error('Cant have more than 3 par files in this folder');
end


[a,b,c] = imgRecon_parrec(parf(1).name);
MagIm=mean(a(:,:,:,1,1,1,:),7);



if(length(parf)>1)
    [a,b,c] = imgRecon_parrec(parf(2).name);
    MagIm=MagIm+mean(a(:,:,:,1,1,1,:),7);
end

if(length(parf)>2)
    [a,b,c] = imgRecon_parrec(parf(3).name);
    MagIm=MagIm+mean(a(:,:,:,1,1,1,:),7);
end

montagestack(MagIm)

save MagIm MagIm