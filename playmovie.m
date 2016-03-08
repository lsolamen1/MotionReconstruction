%% movie

clear atp M;
X1 = 31;
S1 = 3;
D1 = 1;
nPh = 8;
t=[1:nPh];
% atp = UGcim(:,:,:,6);
atp = Gcim(:,:,:,S1);
figure;

Nk = size(atp,1);
for k = 5:55 %%Nk
    p=reshape(atp(X1,k,:),[1 nPh]);
    p=p-mean(p);
    plot(t,p,'-*'); 
    axis([1 nPh -1 1]);

    At = A(X1,k,S1,D1);
    Pt = P(X1,k,S1,D1);
    tD = At.*cos(Pt+(t-1).*2*pi/nPh);
    hold on;plot(t,tD,'-r*'); 

    M(k) = getframe;
    hold off;
end

% abdiff(:,1) = [unwrap(p)-p]';

% movie(M,1,1);

%% permute
%% deblank
%% strtrim
