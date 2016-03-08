%% This function smoothes a series of number
function sr = Smoother(r)

n = length(r);
sr(1) = r(1);
for i=1:n-1
    dr(i) = Grad(r(i+1), r(i));
    sr(i+1) = sr(i) + dr(i);
end

for i=1:n
    r = sr(i);
    r = mod(r,2*pi);
    if (r>pi) 
        r = r - 2*pi;
    elseif (r<-pi)
        r = r + 2*pi;
    end
    sr(i) = r;
end




