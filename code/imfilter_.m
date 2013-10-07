function c=imfilter_( a, b, command )
sz = size(b);
h=sz(1);
w=sz(2);
hh=(h-1)/2;
ww=(w-1)/2;
sz2=size(a);
ha=sz2(1);
wa=sz2(2);
ta=sz2(3);
c=a;
for i=hh+1:ha-hh
    for j=ww+1:wa-ww
        for k=1:ta
            c(i,j,k) = sum(sum(a(i-hh:i+hh,j-ww:j+ww,k).*b));
        end
    end
end

end

