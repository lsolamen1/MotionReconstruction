function DirIndex=DirRead(parms,fat_shift)

% Computing Tpom matrix - going from magnetic to patient coordinate system

% Head First
if(strcmp(strcat(parms.patient_position),'Head First Prone')==1)
    tpo=[-1 0 0;0 -1 0;0 0 1];
    tpp=[0 1 0;-1 0 0;0 0 -1];
end

if(strcmp(strcat(parms.patient_position),'Head First Supine')==1)
    tpp=[0 1 0;-1 0 0;0 0 -1];
    tpo=[1 0 0;0 1 0;0 0 1];
end

if(strcmp(strcat(parms.patient_position),'Head First Rightcubitus')==1)
    tpp=[0 1 0;-1 0 0;0 0 -1];
    tpo=[0 -1 0;1 0 0;0 0 1] ;
end

if(strcmp(strcat(parms.patient_position),'Head First Leftcubitus')==1)
    tpp=[0 1 0;-1 0 0;0 0 -1];
    tpo=[0 1 0;-1 0 0;0 0 1]; 
end

% Feet First

if(strcmp(strcat(parms.patient_position),'Feet First Prone')==1)
    tpo=[-1 0 0;0 -1 0;0 0 1];
    tpp=[0 -1 0;-1 0 0;0 0 1];
end

if(strcmp(strcat(parms.patient_position),'Feet First Supine')==1)
    tpp=[0 -1 0;-1 0 0;0 0 1];
    tpo=[1 0 0;0 1 0;0 0 1];
end

if(strcmp(strcat(parms.patient_position),'Feet First Rightcubitus')==1)
    tpp=[0 -1 0;-1 0 0;0 0 1];
    tpo=[0 -1 0;1 0 0;0 0 1];
end

if(strcmp(strcat(parms.patient_position),'Feet First Leftcubitus')==1)
    tpp=[0 -1 0;-1 0 0;0 0 1];
    tpo=[0 1 0;-1 0 0;0 0 1];
end

Tpom=tpo*tpp;

% computing the Tang matrix -- going from slice orientation to patient cord

A1=parms.angulation;
%%Hwang
% A1=A1.*0;  
% rl=A1(1);
% ap=A1(2);
% fh=A1(3);
ap=A1(1);
fh=A1(2);
rl=A1(3);

Trl=[1 0 0;0 cos(rl) -sin(rl);0 sin(rl) cos(rl)];
Tap=[cos(ap) 0 sin(ap);0 1 0;-sin(ap) 0 cos(ap)];
Tfh=[cos(fh) -sin(fh) 0;sin(fh) cos(fh) 0;0 0 1];

Tang=Trl*Tap*Tfh;

%% computing the  Tsom matrix -- going from image to slice orientation

if(parms.tags(1,26)==1)
    display('Transverse Scan')
    display(parms.preparation_dir)
    
Tsom=[0 -1 0;-1 0 0;0 0 1];
if(strcmp(strcat(parms.preparation_dir),'Right-Left')==1) 
    Tprep=[1 0 0; 0 1 0; 0 0 1];
    if nargin==1
    fat_shift='P';
    end
end


if(strcmp(strcat(parms.preparation_dir),'Anterior-Posterior')==1)
     Tprep=[0 -1 0; 1 0 0; 0 0 1];
       
       if nargin==1
       fat_shift='L';
       end 
end
display(fat_shift)

end

if(parms.tags(1,26)==2)
    display('Sagital Scan')
    display(parms.preparation_dir)
Tsom=[0 0 -1;0 -1 0;1 0 0];

if(strcmp(strcat(parms.preparation_dir),'Foot-Head')==1)
     Tprep=[0 -1 0; 1 0 0; 0 0 1];
     
end

if(strcmp(strcat(parms.preparation_dir),'Anterior-Posterior')==1 )
     Tprep=[1 0 0; 0 1 0; 0 0 1];
end


display(fat_shift)

end

if(parms.tags(1,26)==3)
    display('Coronal Scan')
    display(parms.preparation_dir)
    Tsom=[0 -1 0;0 0 1;1 0 0];
    if(strcmp(strcat(parms.preparation_dir),'Right-Left')==1)
        
       Tprep=[1 0 0; 0 1 0; 0 0 1];
       if nargin==1
       fat_shift='F';
       end
    end
    
    if(strcmp(strcat(parms.preparation_dir),'Feet-Head')==1)
     Tprep=[0 -1 0; 1 0 0; 0 0 1];
     if nargin==1
     fat_shift='L';
     end
     
end

   display(fat_shift) 
    
end


% Choice  m-filp, s-flip, s-flip based on slice orientation, fold over
% direction and fat-shift direction

% Transverse

if(strcmp(strcat(parms.preparation_dir),'Right-Left')==1 & parms.tags(1,26)==1)
    if(fat_shift == 'R' | fat_shift=='P')
    flips='p';
    end

    if(fat_shift =='L' | fat_shift=='F' | fat_shift=='A')
    flips='m';
    end

    if(fat_shift =='H')
    flips='s';
    end
end

if(strcmp(strcat(parms.preparation_dir),'Anterior-Posterior')==1& parms.tags(1,26)==1)    
    if(fat_shift=='R' | fat_shift=='F' | fat_shift=='A')
      flips='m';
    end

    if(fat_shift=='L' | fat_shift=='P')
      flips='p';
    end

    if(fat_shift=='H')
      flips='s';      
    end
end

% Sagital

if(strcmp(strcat(parms.preparation_dir),'Feet-Head')==1 & parms.tags(1,26)==2)
    
  if(fat_shift=='L' | fat_shift=='H' | fat_shift=='A')
   flips='m';
  end

  if(fat_shift=='F' | fat_shift=='P')
   flips='p';
  end

  if(fat_shift=='R')
  flips='s';
  end
  
end  
if(strcmp(strcat(parms.preparation_dir),'Anterior-Posterior')==1& parms.tags(1,26)==2)    

  if(fat_shift=='L' | fat_shift=='H' | fat_shift=='P')
   flips='m';
  end

  if(fat_shift=='A' | fat_shift=='F')
   flips='p';
  end

  if(fat_shift=='R')
  flips='s';
  end

end

% Coronal
if(strcmp(strcat(parms.preparation_dir),'Feet-Head')==1 & parms.tags(1,26)==3)
    
  if(fat_shift=='R' | fat_shift=='H' | fat_shift=='A')
   flips='m';
  end

  if(fat_shift=='L' | fat_shift=='F')
   flips='p';
  end

  if(fat_shift=='P')
  flips='s';
  end 
  
end
if(strcmp(strcat(parms.preparation_dir),'Right-Left')==1& parms.tags(1,26)==3)  

  if(fat_shift=='L' | fat_shift=='H' | fat_shift=='A')
   flips='m';
  end

  if(fat_shift=='R' | fat_shift=='F')
   flips='p';
  end

  if(fat_shift=='P')
  flips='s';    
  end
    
end


if (flips=='m')   
Tfsd=[-1 0 0;0 1 0;0 0 1];
end

if(flips=='p')
Tfsd=[1 0 0;0 -1 0;0 0 1];
end

if(flips=='s')
Tfsd=[1 0 0;0 1 0;0 0 -1];
end

Txyz=Tprep*Tfsd;

% A=inv(Tpom)*Tang*Tsom*Txyz;
% B=inv(Tpom)*Tang*Tsom;
% 
% MOT=[inv(A)';0,0,0];
% CORD=[inv(B)';parms.tags(1,29),parms.tags(1,30),parms.tags(1,23)];
% % MOT=[A;0,0,0];
% % CORD=[B;parms.tags(1,29),parms.tags(1,30),parms.tags(1,23)];
% 
% DirIndex=[CORD,MOT];


%% DIRINDEX

% Philips DirIndex = [LHS     RHS 
%                     SPACING 0 0 0] where
% LHS = image (NWV) to (left-handed) magnet coordinates (XYZ)
% RHS = motion (MPS) to (left-handed) magnet coordinates (XYZ)
% SPACING = pixel spacing x,y,z
		
LHS=inv(Tpom)*Tang*Tsom;
RHS=inv(Tpom)*Tang*Tsom*Txyz;
SPACING = [parms.tags(1,29),parms.tags(1,30),parms.tags(1,23)+parms.tags(1,24)];
                % added slice gap to the z slice thickness

% LHS=[LHS;SPACING];
% RHS=[RHGS;0 0 0];
% DirPHILIPS=[MESH,MOTION];

% To solve in right-handed MESH coordinate system:

NWV2ijk = [0 -1 0; -1 0 0; 0 0 1];	% image (NWV) to MESH (ijk) coordinates

NLHS = eye(3);				% MESH (ijk) to MESH coordinates = ID
NRHS = NWV2ijk*inv(LHS)*RHS;		% motion (MPS) to MESH (ijk) coordinates
SPACING = abs(NWV2ijk*SPACING');

MESH=[NLHS;SPACING'];
MOTION=[NRHS;0,0,0];

DirIndex=[MESH,MOTION];
