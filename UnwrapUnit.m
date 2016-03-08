function [At,Pt,UGt,tRmt,FlagMtr,RefMtr,k]=UnwrapUnit(x,y,nX,nY,At,Pt,UGt,tRmt,FlagMtr,RefMtr,k);

if (x>1 && y>1 && x<nX && y<nY && tRmt(x,y)>0) 
    [At,Pt,UGt,tRmt,FlagMtr,k]=UnwrapNeighbor(x,y,At,Pt,UGt,tRmt,FlagMtr,k);
    if FlagMtr(x,y)==0
        FlagMtr(x,y)=1;
        k = k+1;
    end
    RefMtr(x,y)=1;
else
    FlagMtr(x,y)=1;
    RefMtr(x,y)=1;
    k = k+1;
end              

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [At,Pt,UGt,tRmt,Flag,k]=UnwrapNeighbor(x,y,At,Pt,UGt,tRmt,Flag,k);

M = [x-1 x+1 x x];
N = [y y y-1 y+1];
nPh = size(UGt,3);

for i=1:4;
    m = M(i);
    n = N(i);
%         if (n>57 & n<63 & m>59 & m<64)
%             [x y]
%         end
    if Flag(m,n)==1 || tRmt(m,n)==0
        continue;
    elseif Flag(m,n)==0 && tRmt(m,n)<=tRmt(x,y) && tRmt(m,n)>0
        Flag(m,n)=1;
        k = k+1;
        continue;
    else
        temp = reshape(UGt(m,n,:)-UGt(x,y,:),1,nPh);
        tempr = Smoother(temp);
        UGt(m,n,:) = reshape(UGt(x,y,:),1,nPh)+tempr;
        temp = reshape(UGt(m,n,:),1,nPh);
        [At(m,n),Pt(m,n),tD,tRmt(m,n)] = FFTReconSingle(temp,nPh);          
%         [at,pt,dt,rt] = FFTReconSingle(temp,nPh);
%         if rt./at > 1
% %             figure;plot(temp,'-*');
%             [UF,at,pt,rt] = FFTRMSFit(temp);
% %             hold on;plot(UF,'-go');
%             At(m,n) = at;
%             Pt(m,n) = pt;
%             tRmt(m,n) = rt;
%             UGt(m,n,:) = UF;
%         end

%         if abs(at-At(x,y))<=0.5
%             At(m,n) = at;
%             Pt(m,n) = pt;
%             tRmt(m,n) = rt;
%         end        
        Flag(m,n)=1;
%         if m==41 && n==17
%             [x y]
%         end
        k = k+1;
    end
end
