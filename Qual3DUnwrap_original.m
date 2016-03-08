function UGcim = Qual3DUnwrap_original(Gcim,mask)
%==========================================================================
% The three-dimensional quality-guided phase unwrapping method.
% Created by    Huifang Wang, PhD 
%               Thayer School of Engineering, Dartmouth College
%               Date: 1/20/2008
%==========================================================================


[nX,nY,nPh,nS] = size(Gcim);

A0=zeros(nX,nY);
P0=zeros(nX,nY);
tRm0=zeros(nX,nY);
UGcim0 = zeros(nX,nY,nPh);

%% Initial unwrapping to get quality map
for k = 1:nS
    for ii = 1:nX
        for jj = 1:nY
            if mask(ii,jj,k)==1
              temp = reshape(Gcim(ii,jj,:),1,nPh);
              temp = unwrap(temp);
              [A0(ii,jj,k),P0(ii,jj,k),tD,tRm0(ii,jj,k)] = FFTReconSingle(temp,nPh);     
              UGcim0(ii,jj,:) = temp;
            end
        end
    end
end

%% Quality-guided 3D process

A=A0;P=P0;tRm=tRm0;UGcim=UGcim0;
FlagMtr = 1 - mask;
RefMtr = 1 - mask;

k = 0;
bb = tRm(find(tRm>0));
bbsort = sort(bb);
for i=1:length(bb);
%     if k==length(bb) 
% %         [k i]
%         break; 
%     end;
    bb = tRm(find(tRm>0));
    bbsort2 = sort(bb);
    if bbsort2(1:i)==bbsort(1:i)
        [x,y] = find(tRm==bbsort2(i));
        [A,P,UGcim,tRm,FlagMtr,RefMtr,k]=UnwrapUnit(x(1),y(1),nX,nY,A,P,UGcim,tRm,FlagMtr,RefMtr,k);
    else
        for j=1:i
            [x,y] = find(tRm==bbsort2(j));
            if RefMtr(x,y)==1 continue; end
            if isempty(x)     continue; end
            [A,P,UGcim,tRm,FlagMtr,RefMtr,k]=UnwrapUnit(x(1),y(1),nX,nY,A,P,UGcim,tRm,FlagMtr,RefMtr,k);
        end
    end
    bbsort = bbsort2;
end
